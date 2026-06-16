import 'package:librelab_shared/result.dart';

sealed class UserRegisterFailure extends Failure {
  const UserRegisterFailure(super.message);
}

final class InvalidPasswordLengthFailure extends UserRegisterFailure {
  const InvalidPasswordLengthFailure()
    : super('Password length is not in the allowed range');
}

final class CommonPasswordFailure extends UserRegisterFailure {
  const CommonPasswordFailure() : super('A common/insecure password detected');
}

final class InvalidFullNameLengthFailure extends UserRegisterFailure {
  const InvalidFullNameLengthFailure()
    : super('Full name length is not in the allowed range');
}

final class InvalidPhoneNumberLengthFailure extends UserRegisterFailure {
  const InvalidPhoneNumberLengthFailure()
    : super('Phone number is not the allowed range');
}

final class InvalidEmailFormatFailure extends UserRegisterFailure {
  const InvalidEmailFormatFailure() : super('Email format/syntax is invalid');
}

final class EmailInUseFailure extends UserRegisterFailure {
  const EmailInUseFailure() : super('Email is already in use');
}
