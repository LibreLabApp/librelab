import 'dart:io';

import 'package:librelab_server/config/app_config/app_config.dart';
import 'package:librelab_server/config/app_config/app_config_repository.dart';
import 'package:librelab_server/mdns/prompt_config.dart';
import 'package:librelab_server/utils/server_port_availability.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:librelab_shared/librelab_shared.dart';

Future<AppConfig> loadAppConfig(
  AppConfigRepository repository, {
  required String Function() getConfigFilePath,
  required Shutdown shutdown,
}) async {
  final appConfig = await repository.load();
  if (appConfig == null) {
    final apiPort = await findAvailablePortOrShutdown(
      preferredPort: ProjectConstants.defaultApiPort,
      shutdown: shutdown,
    );
    final defaultConfig = AppConfig.defaultConfig(
      mdnsServicePublish: promptMdnsServicePublishConfig(),
      port: apiPort,
    );
    await repository.save(defaultConfig);

    stdout.writeln(
      'Created "${getConfigFilePath()}" with default config (API server port: $apiPort).\n'
      'Important: If you are deploying to the cloud, please read the following cloud deployment notes!\n'
      'For local networks, the default is sufficient.\n\n'
      'Cloud deployment notes (not required for local networks):'
      '\n'
      '1. Use a reverse proxy/load balancer for HTTPS (e.g., Nginx)\n'
      '2. Update host, port, and scheme for API and database\n'
      '3. Update the sslMode of database from disable to verifyFull (if using non-localhost database)\n'
      '4. Update address from 0.0.0.0 to 127.0.0.1\n\n'
      'Note: PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)',
    );

    return defaultConfig;
  }
  return appConfig;
}
