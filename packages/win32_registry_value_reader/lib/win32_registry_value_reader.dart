import 'package:win32_registry/win32_registry.dart';

String? readStringValueFromLocalMachine({
  required String keyPath,
  required String valueName,
}) {
  RegistryKey? key;
  try {
    key = LOCAL_MACHINE.open(keyPath);
    return key.getString(valueName);
  } on Exception catch (_) {
    return null;
  } finally {
    key?.close();
  }
}
