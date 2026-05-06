import 'dart:io';

import 'package:librelab_server/src/mdns/mdns_service_config.dart';
import 'package:librelab_server/src/utils/cli_helpers.dart';
import 'package:mdns_dart/mdns_dart.dart';

abstract interface class MdnsDriver {
  factory MdnsDriver.dart() => _DartMdnsDriver();

  Future<void> start(MdnsServiceConfig config);
  Future<void> stop();
}

abstract class ProcessMdnsDriver implements MdnsDriver {
  ProcessMdnsDriver({
    required this.executable,
    required this.buildArguments,
    required this.logStdout,
  });

  factory ProcessMdnsDriver.macOS({required bool logStdout}) =>
      _MacOsProcessMdnsDriver(logStdout: logStdout);

  final String executable;
  final List<String> Function(MdnsServiceConfig config) buildArguments;
  final bool logStdout;

  Process? _process;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    _process = await runCommandStream(
      executable,
      buildArguments(config),
      logStdout: logStdout,
    );

    _process!.exitCode
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
    _process?.kill(ProcessSignal.sigterm);
    _process = null;
  }
}

final class _MacOsProcessMdnsDriver extends ProcessMdnsDriver {
  _MacOsProcessMdnsDriver({required super.logStdout})
    : super(
        executable: 'dns-sd',
        buildArguments: (MdnsServiceConfig config) => [
          '-R',
          config.instanceName,
          config.serviceType,
          '.',
          '${config.port}',
        ],
      );
}

final class _DartMdnsDriver implements MdnsDriver {
  MDNSServer? _server;

  @override
  Future<void> start(MdnsServiceConfig config) async {
    final service = await MDNSService.create(
      instance: config.instanceName,
      service: config.serviceType,
      port: config.port,
    );
    _server = MDNSServer(MDNSServerConfig(zone: service));
    await _server!.start();
  }

  @override
  Future<void> stop() async {
    await _server?.stop();
    _server = null;
  }
}
