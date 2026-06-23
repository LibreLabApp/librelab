import 'package:path/path.dart' as p;

class AppFilePaths({required final String? _workingDirectory}) {
  String _resolve(String path) {
    if (_workingDirectory != null) {
      return p.join(_workingDirectory, path);
    }
    return path;
  }

  String get configDir => _resolve('config');

  String _insideConfigDir(String path) => p.join(configDir, path);

  String get config => _insideConfigDir('config.yaml');
  String get secrets => _insideConfigDir('secrets.yaml');
}
