import 'dart:io';

import 'package:librelab_server/src/config/app_config.dart';
import 'package:librelab_server/src/config/config_files.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class AppConfigRepository {
  AppConfigRepository({required String runMode})
    : _file = ConfigFiles.forRunMode(runMode);

  final File _file;
  AppConfig? _config;

  // https://github.com/serverpod/serverpod/issues/633#issuecomment-2938983574
  static const _appKey = 'app';

  AppConfig? get config => _config;
  AppConfig get configOrThrow =>
      config ?? (throw StateError('$AppConfig must not be null'));

  Future<AppConfig?> load() async {
    final content = await _file.readAsString();
    final root = loadYaml(content) as YamlMap;

    final appNode = root[_appKey] as YamlMap?;
    if (appNode == null) {
      return null;
    }
    return _config = AppConfig.fromYaml(appNode);
  }

  Future<void> save(AppConfig config) async {
    _config = config;

    final editor = YamlEditor(await _file.readAsString());
    editor.update([_appKey], config.toYaml());

    await _file.writeAsString(editor.toString());
  }

  Future<void> update({MdnsConfig? mdns, bool? postgresInstallDeclined}) async {
    await save(
      configOrThrow.copyWith(
        mdns: mdns,
        postgresInstallDeclined: postgresInstallDeclined,
      ),
    );
  }
}
