import 'dart:async';

import 'package:bonsoir/bonsoir.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';

// Allow consumers to create a BonsoirDiscovery without directly adding
// the bonsoir dependency.
export 'package:bonsoir/bonsoir.dart' show BonsoirDiscovery;

class BonsoirMdnsServiceDiscovery implements MdnsServiceDiscovery {
  /// Consumers should create [BonsoirDiscovery] and pass it to [discoveryFactory]
  /// without calling [BonsoirDiscovery.stop] or [BonsoirDiscovery.initialize]
  /// since it is managed by this class.
  BonsoirMdnsServiceDiscovery({
    // Uses factory to create a new instance on refresh to avoid assertion failure: "You should not try to start a stopped action"
    //
    // This is acceptable since Bonsoir uses platform-specific APIs and doesn't open
    // a full mDNS client on its own (unlike multicast_dns), and even
    // the example follows a similar behavior:
    // https://github.com/Skyost/Bonsoir/blob/main/packages/bonsoir/example/lib/models/discovery.dart
    required BonsoirDiscovery Function() discoveryFactory,
    required Logger logger,
  }) : _logger = logger,
       _discoveryFactory = discoveryFactory;

  final BonsoirDiscovery Function() _discoveryFactory;
  final Logger _logger;

  BonsoirDiscovery? _discovery;

  /// Completes when the underlying platform discovery has started.
  ///
  /// Used by [discoverServers] to delay the timeout countdown until
  /// a [BonsoirDiscoveryStartedEvent] is received.
  late Completer<void> _startCompleter;

  /// Completes when the underlying platform discovery has stopped.
  ///
  /// Used by [discoverServers] to delay cancellation of the
  /// [BonsoirDiscovery.eventStream] subscription until a
  /// [BonsoirDiscoveryStoppedEvent] is received.
  late Completer<void> _stopCompleter;

  @override
  Stream<MdnsServiceDiscoveryEvent> discoverServices({
    Duration timeout = const Duration(seconds: 5),
  }) async* {
    if (_discovery != null) {
      throw StateError(
        'Must not call discoverServices() again while still running',
      );
    }
    final discovery = _discoveryFactory();
    _discovery = discovery;

    await discovery.initialize();

    final eventStream =
        discovery.eventStream ??
        (throw StateError(
          '$BonsoirDiscovery.eventStream is null. Was $BonsoirDiscovery.initialize() called?',
        ));

    final controller = StreamController<MdnsServiceDiscoveryEvent>();

    final sub = eventStream.listen(
      (event) => _onEventOccurred(
        event,
        controller,
        serviceResolver: discovery.serviceResolver,
      ),
    );

    _startCompleter = Completer();
    _stopCompleter = Completer();

    await discovery.start();

    unawaited(
      Future<void>(() async {
        /// Timeout for the underline platform discovery lifecycle events (start/stop).
        ///
        /// On iOS simulator, local network discovery is unsupported,
        /// so [BonsoirDiscoveryStartedEvent] and [BonsoirDiscoveryStoppedEvent]
        /// may not fire.
        const platformStartStopTimeout = Duration(seconds: 2);

        /// Delay the timeout countdown until a [BonsoirDiscoveryStartedEvent] is received
        try {
          await _startCompleter.future.timeout(platformStartStopTimeout);
        } on TimeoutException catch (_) {
          _logger.warning(
            '$BonsoirDiscoveryStartedEvent did not occur even after ${platformStartStopTimeout.inSeconds} seconds',
          );
        }

        await Future<void>.delayed(timeout);

        await discovery.stop();
        _discovery = null;

        /// Wait for [BonsoirDiscoveryStoppedEvent] to occur
        /// before canceling the subscription. This is required for logging.
        /// Must be called after "discovery.stop()" or the event will never occur.
        try {
          await _stopCompleter.future.timeout(platformStartStopTimeout);
        } on TimeoutException catch (_) {
          _logger.warning(
            '$BonsoirDiscoveryStoppedEvent did not occur even after ${platformStartStopTimeout.inSeconds} seconds',
          );
        }

        await sub.cancel();
        await controller.close();
      }),
    );

    await for (final event in controller.stream) {
      yield event;
    }
  }

  void _onEventOccurred(
    BonsoirDiscoveryEvent event,
    StreamController<MdnsServiceDiscoveryEvent> controller, {
    required ServiceResolver serviceResolver,
  }) {
    switch (event) {
      case BonsoirDiscoveryServiceFoundEvent(:final service):
        _logger.finer('Service found. Resolving service: ${service.toJson()}');
        service.resolve(serviceResolver);
      case BonsoirDiscoveryServiceResolvedEvent(:final service):
        _logger.finer('Service resolved: ${service.toJson()}');
        controller.add(
          Resolved(
            serviceInfo:
                _mapService(service) ??
                (throw StateError(
                  '$BonsoirService.hostname is null. Does this platform support mDNS hostname?\n'
                  'Bonsoir service: ${service.toJson()}',
                )),
          ),
        );
      case BonsoirDiscoveryServiceUpdatedEvent(:final service):
        _logger.finer('Service updated: ${service.toJson()}');

        final mapped = _mapService(service);
        if (mapped != null) {
          controller.add(Updated(serviceInfo: mapped));
        } else {
          _logger.fine(
            'This "service updated" event will be ignored: $BonsoirService.hostname is null',
          );
        }

      case BonsoirDiscoveryServiceLostEvent(:final service):
        _logger.finer('Service lost: ${service.toJson()}');
        controller.add(
          Lost(
            serviceInfo:
                _mapService(service) ??
                (throw Exception(
                  'Service lost but $BonsoirService.hostname is null.\n'
                  'The hostname is required to identify which service '
                  'should be removed from the list.',
                )),
          ),
        );
      case BonsoirDiscoveryServiceResolveFailedEvent():
        _logger.finer(
          'Service resolve attempt failed (non-fatal, may be retried)',
        );
      case BonsoirDiscoveryStartedEvent():
        _logger.finer('Service discovery started');
        _startCompleter.complete();
      case BonsoirDiscoveryStoppedEvent():
        _logger.finer('Service discovery stopped');
        _stopCompleter.complete();
      case BonsoirDiscoveryUnknownEvent():
        _logger.finer('Unknown discovery event received (ignored)');
    }
  }

  /// Returns null if [BonsoirService.hostname] is `null`.
  MdnsServiceInfo? _mapService(BonsoirService bonsoir) {
    final hostname = bonsoir.hostname;
    if (hostname == null) {
      return null;
    }
    return MdnsServiceInfo(
      hostname: hostname,
      ipAddress: bonsoir.hostAddress,
      port: bonsoir.port,
      instanceName: bonsoir.name,
      txtRecords: bonsoir.attributes,
    );
  }

  @override
  Future<void> start() async {
    // No-op
    // Bonsoir uses platform-specific APIs, and the actual mDNS client
    // is typically managed by the operating system
  }

  @override
  Future<void> stop() async {
    await _discovery?.stop();
    _discovery = null;
  }
}
