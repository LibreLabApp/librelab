import 'package:librelab_shared/librelab_shared.dart';

HttpUrlValidationFailure? validateServerAddressInput(String input) {
  final normalizedInput = prependAuthorityDelimiterIfMissing(input);
  return validateHttpUrl(normalizedInput);
}
