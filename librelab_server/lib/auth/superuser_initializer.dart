import 'dart:io';

import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/security/commonly_used_passwords.dart';
import 'package:librelab_server/user/user.dart';
import 'package:librelab_server/user/user_repository.dart';
import 'package:librelab_server/utils/cli_input.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:librelab_shared/result.dart';
import 'package:meta/meta.dart';

// During server initialization only (CLI).
// Should not be consumed by the API server.
class SuperUserInitializer({
  required final UserRepository _repository,
  required final AuthService _authService,
  required final Shutdown _shutdown,
}) {
  /// Creates a super user if there is no one in the database, which is required to log in to the desktop app.
  ///
  /// If there is no super user, the program will prompt in the command-line
  /// to create the super account credentials. If the input is invalid or empty, the server will terminate.
  ///
  /// Returns whether a new user was created or not.
  Future<bool> ensureHasSuperUser() async {
    final exists = await _repository.hasUsers();
    if (exists) {
      return false;
    }

    await createSuperUser();

    return true;
  }

  Future<void> createSuperUser() async {
    stdout.writeln('''
================================================================
  SUPER USER CREATION
================================================================
To access the desktop application, at least one user
must exist to manage the server.

Account registration cannot be done directly from the desktop interface
without an existing superuser.

Two types of users exist:

- Super user: has full system access and can manage all data,
  including creating and managing other users without needing explicit permissions.
- Normal user: has limited access based on assigned roles or
  permissions.

Normal users can be created by a super user.

After creating the super user, you may use those credentials
to sign in to the desktop application.
----------------------------------------------------------------
''');
    final credentials = await _promptUserCredentials();

    if (await _repository.isEmailUsed(credentials.email)) {
      stderr.writeln(
        '\nEmail address is already in use: ${credentials.email}\n',
      );
      return;
    }

    final registered = await _registerUser(credentials);
    if (!registered) {
      await _shutdown.call(isSuccess: false);
    }

    stdout.writeln('''
\nSuper user created successfully.

After logging in, additional users can be created directly from the application interface.
''');
  }

  Future<bool> _registerUser(_SuperUserInput input) async {
    final result = await _authService.registerUser(
      email: input.email,
      plainPassword: input.password,
      fullName: input.fullName,
      phoneNumber: null,
      type: const SuperUserType(),
    );
    switch (result) {
      case SuccessResult<User, UserRegisterFailure>():
        return true;
      case FailureResult<User, UserRegisterFailure>(:final failure):
        switch (failure) {
          case CommonPasswordFailure():
          case InvalidPhoneNumberLengthFailure():
          case InvalidEmailFormatFailure():
          case EmailInUseFailure():
            // The cases above are already handled before calling this method.
            stderr.writeln('Unexpected error: failed to register the user.');
            return false;
          case InvalidPasswordLengthFailure():
            stderr.writeln('Password length must be in range (8-255)');
            return false;
          case InvalidFullNameLengthFailure():
            stderr.writeln('Full name length must be in range (1-100)');
            return false;
        }
    }
  }
}

@immutable
final class const _SuperUserInput({
  required final String email,
  required final String password,
  required final String fullName,
});

Future<_SuperUserInput> _promptUserCredentials() async {
  final email = promptInput(
    'Enter Email',
    allowEmpty: false,
    validateInput: (input) => EmailValidator.validate(input)
        ? null
        : 'Invalid email format. Provide a standard email address.',
  );

  final password = promptInput(
    'Enter Password',
    allowEmpty: false,
    validateInput: (input) => isCommonPassword(input)
        ? 'This password is commonly used. Please consider a stronger password.'
        : null,
  );

  final fullName = promptInput('Enter Full Name', allowEmpty: false);

  return _SuperUserInput(email: email, password: password, fullName: fullName);
}
