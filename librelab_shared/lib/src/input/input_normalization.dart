import 'package:librelab_shared/src/input/input_validation.dart';

/// Prepends `https://` if [value] has no scheme.
///
/// Returns the normalized value.
String prependsHttpsIfNoScheme(String value) {
  return hasScheme(value) ? value : 'https://$value';
}
