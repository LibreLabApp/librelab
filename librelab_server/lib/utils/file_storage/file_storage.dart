import 'dart:io';

import 'package:logging/logging.dart';

typedef Decoder<T> = T Function(String content);
typedef Encoder<T> = String Function(String? fileContent, T value);

class FileStorage<Decode, Encode> {
  FileStorage({required this._decode, required this._encode, this._logger});

  final Decoder<Decode> _decode;
  final Encoder<Encode> _encode;
  final Logger? _logger;

  String? _fileContent;

  /// Missing or corrupt cache is not a fatal error.
  /// Silent [FormatException] and [FileSystemException].
  Future<Decode?> read(File file) async {
    try {
      if (!file.existsSync()) {
        return null;
      }

      final content = await file.readAsString();
      _fileContent = content;

      return _decode(content);
    } on FormatException catch (e) {
      _logger?.warning('Unexpected file content format ${file.path}: \n$e');
      return null;
    } on FileSystemException catch (e) {
      _logger?.warning(
        'Failed to read file ${file.path} (unexpected operation failure):',
        e,
      );
      return null;
    }
  }

  Future<void> write(File file, Encode value) async {
    try {
      final newFileContent = _encode(_fileContent, value);

      await file.parent.create(recursive: true);
      await file.writeAsString(newFileContent);

      _fileContent = newFileContent;
    } on FileSystemException catch (e) {
      _logger?.warning('Failed to write file: ${file.path}', e);
      rethrow;
    }
  }
}
