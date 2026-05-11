import 'dart:async';
import 'dart:io';

import 'package:librelab_server/src/mdns/mdns_service_config.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:mdns_dart/mdns_dart.dart' as mdns_dart;

abstract interface class MdnsDriver {
  Future<void> start(MdnsServiceConfig config);
  Future<void> stop();
}

/// Base implementation for mDNS drivers backed by a long-running
/// external process.
///
/// [start] launches [executable] asynchronously using [Process.start].
///
/// [stop] attempts graceful shutdown via `SIGTERM`, then force-kills
/// the process with `SIGKILL` if it does not exit within 6 seconds.
///
/// Logging is hardcoded in the implementation.
abstract class ExternalProcessMdnsDriver implements MdnsDriver {
  ExternalProcessMdnsDriver({
    required this.executable,
    required this.buildArguments,
  });

  final String executable;
  final List<String> Function(MdnsServiceConfig config) buildArguments;

  Process? _process;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    final process = await executeCommandStream(
      executable,
      buildArguments(config),
    );
    _process = process;

    process.exitCode
        .then((code) {
          final message =
              '[$executable] process exited with code ${humanExitCode(code)}';

          if (code != 0) {
            stderr.writeln(message);
          } else {
            stdout.writeln(message);
          }
        })
        // ignore: unawaited_futures
        .catchError((Object? e) {
          stderr.writeln('[$executable] Failed to read exit code: $e');
        });
  }

  @override
  Future<void> stop() async {
    final process = _process;
    if (process == null) {
      return;
    }

    process.kill(ProcessSignal.sigterm);
    const timeout = Duration(seconds: 6);
    try {
      await process.exitCode.timeout(timeout);
    } on TimeoutException catch (_) {
      process.kill(ProcessSignal.sigkill);

      stdout.writeln(
        '[$executable] Force kill process after ${timeout.inSeconds} seconds',
      );
    } finally {
      _process = null;
    }
  }
}

/// Uses the system `dns-sd` command for mDNS service registration.
///
/// - macOS: `dns-sd` is built-in.
/// - Windows: requires installation of [Bonjour Services](https://support.apple.com/en-us/106380):
/// (install only `Bonjour64.msi`, which is inside `BonjourPSSetup.exe` file)
///
/// https://developer.apple.com/documentation/dnssd
final class DnsSdMdnsDriver extends ExternalProcessMdnsDriver {
  DnsSdMdnsDriver()
    : super(
        executable: command,
        buildArguments: (config) => [
          '-R',
          config.instanceName,
          config.serviceType,
          '.',
          '${config.port}',
        ],
      );
  static const String command = 'dns-sd';
}

/// Uses the system `avahi-publish` command for mDNS service registration.
///
/// Linux counterpart to [DnsSdMdnsDriver].
///
/// https://avahi.org/
final class AvahiMdnsDriver extends ExternalProcessMdnsDriver {
  AvahiMdnsDriver()
    : super(
        executable: command,
        buildArguments: (config) => [
          '-s',
          config.instanceName,
          config.serviceType,
          '${config.port}',
        ],
      );

  static const String command = 'avahi-publish';
}

/// Uses the [mdns_dart](https://pub.dev/packages/mdns_dart) package.
///
/// Known issues (at least according to Ellet's testing):
///
/// - macOS: Throws during socket initialization with:
///   `Bad state: Failed to create any multicast sockets`
///
/// - Linux/Windows: May start successfully.
///   OS-level .local hostname resolution is not functional
///   (e.g., no responses or `null` ping results in clients).
///
/// These issues can probably be addressed, however it
/// may not work depending on the OS and platform environment,
/// so this implementation should be used as a fallback in
/// case there are other implementations.
final class FallbackMdnsDriver implements MdnsDriver {
  mdns_dart.MDNSServer? _server;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    final service = await mdns_dart.MDNSService.create(
      instance: config.instanceName,
      service: config.serviceType,
      port: config.port,
    );
    _server = mdns_dart.MDNSServer(mdns_dart.MDNSServerConfig(zone: service));
    await _server!.start();
  }

  @override
  Future<void> stop() async {
    await _server?.stop();
    _server = null;
  }
}
