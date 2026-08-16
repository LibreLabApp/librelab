import 'package:librelab_shared/src/input/input_validation.dart'
    show EmailValidator;

abstract final class AuthInputRules {
  static bool isPasswordLengthValid(String password) =>
      password.length >= 8 && password.length <= 255;

  static bool isEmailFormatValid(String email) =>
      EmailValidator.validate(email);
}
