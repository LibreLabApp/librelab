import 'dart:io';

import 'package:string_storage/string_storage.dart';

typedef FileResolver = File Function(String key);

class StringStorageFile implements StringStorage {
  StringStorageFile(this._resolveFile);

  final FileResolver _resolveFile;

  File _file(String key) => _resolveFile(key);

  @override
  Future<String?> read(String key) async {
    final file = _file(key);
    if (!file.existsSync()) {
      return null;
    }
    return file.readAsString();
  }

  @override
  Future<void> write(String key, String value) async {
    final file = _file(key);
    await file.writeAsString(value);
  }

  @override
  Future<bool> delete(String key) async {
    final file = _file(key);
    if (!file.existsSync()) {
      return false;
    }
    await file.delete();
    return true;
  }
}
