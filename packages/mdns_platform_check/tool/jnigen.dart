import 'dart:io';

import 'package:jnigen/jnigen.dart';

void main() async {
  final packageRoot = Platform.script.resolve('../');
  final generator = JniGenerator(
    input: .new(
      classes: ['android.os.Build', 'android.os.ext.SdkExtensions'],
      androidSdk: .new(
        addGradleDeps: true,
        androidExample: packageRoot.resolve('../../librelab_flutter'),
      ),
    ),
    output: .new(
      dart: .new(
        path: packageRoot.resolve('lib/src/mdns_platform_check_android.g.dart'),
        structure: .singleFile,
      ),
    ),
  );
  await generator.generate();
}
