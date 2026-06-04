import 'dart:io';
import 'package:path/path.dart' as p;

class AppFiles {
  AppFiles({required this._workingDirectory});

  final Directory? _workingDirectory;

  String _resolve(String path) {
    if (_workingDirectory != null) {
      return p.join(_workingDirectory.path, path);
    }
    return path;
  }

  File _fileInConfigDir(String path) {
    return File(_resolve(p.join('config', path)));
  }

  File get config => _fileInConfigDir('config.yaml');
  File get secrets => _fileInConfigDir('secrets.yaml');
}
