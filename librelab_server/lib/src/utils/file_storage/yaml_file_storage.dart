import 'package:librelab_server/src/utils/file_storage/file_storage.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class YamlFileStorage extends FileStorage<YamlMap, Map<String, Object?>> {
  YamlFileStorage()
    : super(
        decode: (content) => loadYaml(content) as YamlMap,
        encode: (fileContent, value) {
          final editor = YamlEditor(fileContent ?? _empty);
          editor.update([], value);
          return editor.toString();
        },
      );
  static const _empty = '{}';
}
