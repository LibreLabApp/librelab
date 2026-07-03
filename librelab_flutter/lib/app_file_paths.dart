import 'package:path/path.dart' as p;

class AppFilePaths({required final String? _workingDirectory}) {
  String _resolve(String path) {
    if (_workingDirectory != null) {
      return p.join(_workingDirectory, path);
    }
    return path;
  }

  String get settings => _resolve('settings.json');
}
