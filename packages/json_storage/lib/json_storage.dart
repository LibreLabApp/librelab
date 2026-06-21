import 'package:json_utils/json_utils.dart';
import 'package:logging/logging.dart';
import 'package:result/result.dart';
import 'package:string_storage/string_storage.dart';

class JsonStorage {
  JsonStorage(this._storage, {required this._prettyJson, this._logger});

  final StringStorage _storage;
  final bool _prettyJson;
  final Logger? _logger;

  /// Silently returns `null` in case of [FormatException] (corrupted or invalid JSON).
  Future<JsonMap?> read(String key) async {
    final content = await _storage.read(key);
    if (content == null) {
      return null;
    }
    return switch (tryJsonDecode(content)) {
      SuccessResult<JsonMap, JsonDecodingFailure>(value: final json) => json,
      FailureResult<JsonMap, JsonDecodingFailure>(:final failure) => () {
        _logger?.warning(
          'Unexpected file content format (${_storage.resolvePath(key)})',
          failure.toString(),
        );
        return null;
      }(),
    };
  }

  Future<void> write(String key, JsonMap value) async {
    final json = _prettyJson ? jsonEncodePretty(value) : jsonEncode(value);
    await _storage.write(key, json);
  }
}
