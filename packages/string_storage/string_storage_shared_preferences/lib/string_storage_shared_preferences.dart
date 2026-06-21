import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_storage/string_storage.dart';

export 'package:string_storage/string_storage.dart';

class StringStorageSharedPreferences implements StringStorage {
  StringStorageSharedPreferences(this._sharedPreferences);

  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<String?> read(String key) => _sharedPreferences.getString(key);

  @override
  Future<void> write(String key, String value) =>
      _sharedPreferences.setString(key, value);

  @override
  Future<bool> delete(String key) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  @override
  String resolvePath(String key, {bool absolute = false}) => key;
}
