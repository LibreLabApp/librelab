import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart';
import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_shared/librelab_shared.dart';

Future<void> ensureHasConfig() async {
  final File productionConfigFile = ConfigFiles.production;

  if (productionConfigFile.existsSync()) {
    return;
  }

  await _write(productionConfigFile);
}

Future<void> _write(File productionConfigFile) async {
  final parent = productionConfigFile.parent;
  if (!parent.existsSync()) {
    await parent.create();
  }

  await productionConfigFile.writeAsString(_buildConfigFileContent());

  stdout.writeln(
    'Created "${productionConfigFile.path}" with default config.\n'
    'Important: If you are deploying to the cloud, please read the comments in that file!\n'
    'For local networks, the default is sufficient.\n',
  );
}

String _buildConfigFileContent() {
  return '''
# Important: When deploying the server to the cloud (not required for local networks):
#
# 1. Route traffic through a reverse proxy or load balancer to provide SSL security (HTTPS), e.g.,
# 2. Update host, port, and scheme values for both the API server and database.
# 3. Set requireSsl to true

apiServer:
  port: ${ProjectConstants.defaultApiPort}
  publicHost: localhost
  publicPort: ${ProjectConstants.defaultApiPort}
  publicScheme: http

# insightsServer:
#   port: ${ProjectConstants.defaultInsightsPort}
#   publicHost: localhost
#   publicPort: ${ProjectConstants.defaultInsightsPort}
#   publicScheme: http

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
