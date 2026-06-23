import 'dart:io';

import 'package:string_storage/string_storage.dart';

typedef FileResolver = File Function(String id);

class StringStorageFile(final FileResolver _resolveFile)
    implements StringStorage {
  File _file(String id) => _resolveFile(id);

  @override
  Future<String?> read(String id) async {
    final file = _file(id);
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsString();
  }

  @override
  Future<void> write(String id, String value) async {
    final file = _file(id);
    await file.writeAsString(value);
  }

  @override
  Future<bool> delete(String id) async {
    final file = _file(id);
    if (!file.existsSync()) {
      return false;
    }
    await file.delete();
    return true;
  }

  @override
  String resolvePath(String id, {bool absolute = false}) {
    final file = _file(id);
    if (absolute) {
      return file.absolute.path;
    }
    return file.path;
  }
}
