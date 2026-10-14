import 'package:librelab_shared/result.dart';

sealed class const RegisterFailure(super.message) extends Failure;

final class const InvalidPasswordLengthFailure() extends RegisterFailure {
  this : super('Password length is not in the allowed range');
}

final class const CommonPasswordFailure() extends RegisterFailure {
  this : super('A common/insecure password detected');
}

final class const InvalidFullNameLengthFailure() extends RegisterFailure {
  this : super('Full name length is not in the allowed range');
}

final class const InvalidPhoneNumberLengthFailure() extends RegisterFailure {
  this : super('Phone number is not the allowed range');
}

final class const InvalidEmailFormatFailure() extends RegisterFailure {
  this : super('Email format/syntax is invalid');
}

final class const EmailInUseFailure() extends RegisterFailure {
  this : super('Email is already in use');
}
