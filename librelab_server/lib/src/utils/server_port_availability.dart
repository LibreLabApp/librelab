import 'dart:io';

import 'package:librelab_server/src/config/config_files.dart' show ConfigFiles;
import 'package:librelab_server/src/utils/shutdown.dart';
import 'package:librelab_shared/librelab_shared.dart';

Future<bool> _isPortAvailable(int port) async {
  try {
    final server = await ServerSocket.bind(InternetAddress.anyIPv4, port);
    await server.close();

    return true;
  } on SocketException {
    return false;
  }
}

Future<int?> _findAvailablePort({
  required int preferredPort,
  required int maxRetries,
}) async {
  var port = preferredPort;

  for (var i = 0; i <= maxRetries; i++, port++) {
    if (!isValidPort(port)) {
      return null;
    }
    if (await _isPortAvailable(port)) {
      return port;
    }
  }

  return null;
}

Future<int> findAvailablePortOrShutdown({
  required int preferredPort,
  int maxRetries = 10,
}) async {
  final port = await _findAvailablePort(
    preferredPort: preferredPort,
    maxRetries: maxRetries,
  );
  if (port == null) {
    await shutdown(isSuccess: false);
    throw shutdownInvariantError;
  }
  return port;
}

Future<void> enforcePortAvailability({required int apiServerPort}) async {
  if (!await _isPortAvailable(apiServerPort)) {
    stderr.writeln('''

╔════════════════════════════════════════════════════╗
║                FATAL PORT CONFLICT                 ║
╚════════════════════════════════════════════════════╝

FATAL ERROR: PORT $apiServerPort IS BUSY
The server is configured to use this port.

ADVICE:

- RESTART the operating system.
- Check if another instance is running or 
  use 'netstat' CLI to find the conflicting process.
- You can change the port in "${ConfigFiles.forCurrentRunMode().path}"
  but client connections must be reconfigured to use the new port.

To prevent client connection issues, the application
will now exit instead of silently choosing another port.

╔════════════════════════════════════════════════════╗
║     IMPORTANT: READ ABOVE BEFORE EXIT OCCURS ↑     ║
╚════════════════════════════════════════════════════╝
''');
    await shutdown(isSuccess: false);
    throw shutdownInvariantError;
  }
}
