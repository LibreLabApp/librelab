import 'dart:io';

import 'package:crypto/crypto.dart' show sha256;

Future<bool> verifySha256(File file, String expected) async {
  final hash = await sha256.bind(file.openRead()).first;

  return hash.toString().toLowerCase() == expected.toLowerCase();
}
