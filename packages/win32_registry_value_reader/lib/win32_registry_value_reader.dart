import 'package:win32_registry/win32_registry.dart';

String? readStringValueFromLocalMachine({
  required String keyPath,
  required String valueName,
}) {
  RegistryKey? key;
  try {
    key = Registry.openPath(RegistryHive.localMachine, path: keyPath);
    return key.getStringValue(valueName);
  } on Exception catch (_) {
    return null;
  } finally {
    key?.close();
  }
}
