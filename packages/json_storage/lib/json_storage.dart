import 'package:json_safe/json_safe.dart';
import 'package:logging/logging.dart';
import 'package:string_storage/string_storage.dart';

class JsonStorage({
  required final StringStorage _storage,
  required final bool _prettyJson,
  required final Logger? _logger,
}) {
  Future<JsonMap?> read(String key) async {
    final content = await _storage.read(key);
    if (content == null) {
      return null;
    }
    try {
      return decodeJsonStringToMap(content);
    } on JsonParseException catch (e, stackTrace) {
      _logger?.warning(
        'Unexpected file content format: ${_storage.resolvePath(key)}',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  Future<void> write(String key, JsonMap value) async {
    final json = _prettyJson ? jsonEncodePretty(value) : jsonEncode(value);
    await _storage.write(key, json);
  }
}
