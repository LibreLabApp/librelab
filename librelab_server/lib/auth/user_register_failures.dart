import 'package:librelab_shared/result.dart';

sealed class UserRegisterFailure extends Failure {
  const UserRegisterFailure();
}

final class InvalidPasswordLengthFailure extends UserRegisterFailure {
  const InvalidPasswordLengthFailure();
}

final class CommonPasswordFailure extends UserRegisterFailure {
  const CommonPasswordFailure();
}

final class InvalidFullNameLengthFailure extends UserRegisterFailure {
  const InvalidFullNameLengthFailure();
}

final class InvalidPhoneNumberLengthFailure extends UserRegisterFailure {
  const InvalidPhoneNumberLengthFailure();
}

final class InvalidEmailFailure extends UserRegisterFailure {
  const InvalidEmailFailure();
}

final class EmailInUseFailure extends UserRegisterFailure {
  const EmailInUseFailure();
}
