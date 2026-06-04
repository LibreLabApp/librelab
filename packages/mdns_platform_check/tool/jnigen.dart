import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main() {
  final Uri packageRoot = Platform.script.resolve('../');
  generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve(
            'lib/src/mdns_platform_check_android.g.dart',
          ),
          structure: OutputStructure.singleFile,
        ),
      ),
      androidSdkConfig: AndroidSdkConfig(
        addGradleDeps: true,
        androidExample: '../../librelab_flutter',
      ),
      classes: <String>['android.os.Build', 'android.os.ext.SdkExtensions'],
    ),
  );
}
