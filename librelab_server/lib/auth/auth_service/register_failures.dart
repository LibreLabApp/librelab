import 'package:librelab_shared/result.dart';

sealed class RegisterFailure extends Failure {
  const RegisterFailure(super.message);
}

final class InvalidPasswordLengthFailure extends RegisterFailure {
  const InvalidPasswordLengthFailure()
    : super('Password length is not in the allowed range');
}

final class CommonPasswordFailure extends RegisterFailure {
  const CommonPasswordFailure() : super('A common/insecure password detected');
}

final class InvalidFullNameLengthFailure extends RegisterFailure {
  const InvalidFullNameLengthFailure()
    : super('Full name length is not in the allowed range');
}

final class InvalidPhoneNumberLengthFailure extends RegisterFailure {
  const InvalidPhoneNumberLengthFailure()
    : super('Phone number is not the allowed range');
}

final class InvalidEmailFormatFailure extends RegisterFailure {
  const InvalidEmailFormatFailure() : super('Email format/syntax is invalid');
}

final class EmailInUseFailure extends RegisterFailure {
  const EmailInUseFailure() : super('Email is already in use');
}
