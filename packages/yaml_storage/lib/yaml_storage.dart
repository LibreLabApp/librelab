import 'package:string_storage/string_storage.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class YamlStorage(final StringStorage _storage) {
  Future<YamlMap?> read(String id) async {
    final content = await _storage.read(id);
    if (content == null) {
      return null;
    }
    return loadYaml(content) as YamlMap;
  }

  static const _empty = '{}';

  Future<void> write(String id, Map<String, Object?> value) async {
    // Preserves comments
    final content = await _storage.read(id);

    final editor = YamlEditor(content ?? _empty);
    editor.update([], value);

    final yaml = editor.toString();
    await _storage.write(id, yaml);
  }
}
