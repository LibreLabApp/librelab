import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_server/src/utils/server_port_availability.dart';
import 'package:librelab_shared/librelab_shared.dart';

Future<void> ensureHasConfig() async {
  final File productionConfigFile = ConfigFiles.production;

  if (productionConfigFile.existsSync()) {
    return;
  }

  final apiPort = await findAvailablePortOrShutdown(
    preferredPort: ProjectConstants.defaultApiPort,
  );
  final insightsPort = await findAvailablePortOrShutdown(
    preferredPort: ProjectConstants.defaultInsightsPort,
  );

  await _write(
    productionConfigFile,
    apiPort: apiPort,
    insightsPort: insightsPort,
  );
}

Future<void> _write(
  File productionConfigFile, {
  required int apiPort,
  required int insightsPort,
}) async {
  final parent = productionConfigFile.parent;
  if (!parent.existsSync()) {
    await parent.create();
  }

  await productionConfigFile.writeAsString(
    _buildConfigFileContent(apiPort: apiPort, insightsPort: insightsPort),
  );

  stdout.writeln(
    'Created "${productionConfigFile.path}" with default config (API server port: $apiPort).\n'
    'Important: If you are deploying to the cloud, please read the comments in that file!\n'
    'For local networks, the default is sufficient.\n',
  );
}

String _buildConfigFileContent({
  required int apiPort,
  required int insightsPort,
}) {
  return '''
# Cloud deployment notes (not required for local networks):
#
# 1. Use a reverse proxy/load balancer for HTTPS (e.g., Nginx)
# 2. Update host, port, and scheme for API and database
# 3. Enable requireSsl

apiServer:
  port: $apiPort
  publicHost: localhost
  publicPort: $apiPort
  publicScheme: http

# insightsServer:
#   port: $insightsPort
#   publicHost: localhost
#   publicPort: $insightsPort
#   publicScheme: http

# PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)
database:
  host: localhost
  port: ${PostgresConstants.defaultPort}
  name: ${ProjectConstants.defaultDbName}
  user: ${ProjectConstants.defaultUsername}
  requireSsl: false

# The maximum size of requests allowed in bytes
maxRequestSize: 524288 # 512 KB

sessionLogs:
  consoleEnabled: false
# persistentEnabled: true
''';
}
