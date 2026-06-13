import 'dart:io';

import 'package:librelab_server/utils/cli_input.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:meta/meta.dart';

// TODO: (REMOVE_SERVERPOD) Implement authentication system (current is stub implementation)
//  previous system before migration: https://github.com/LibreLabApp/librelab/blob/d6fa30461e9284c515ea771a94b33e6e695349f6/librelab_server/lib/src/auth/ensure_has_admin_user.dart
//  search for "// STUB IMPLEMENTATION" comments

/// Creates a super user if there is no one in the database, which is required to log in to the desktop app.
///
/// If there is no super user, the program will prompt in the command-line
/// to create the super account credentials. If the input is invalid or empty, the server will terminate.
///
/// Returns whether a new user was created or not.
Future<bool> ensureHasSuperUser() async {
  final exists = await _hasAnyUser();
  if (exists) {
    return false;
  }

  await createSuperUser();

  return true;
}

Future<bool> _hasAnyUser() async {
  // STUB IMPLEMENTATION
  return true;
}

Future<void> createSuperUser() async {
  stdout.writeln('''
================================================================
  SUPER USER CREATION
================================================================
To access the desktop application, at least one user
must exist to manage the server, as the application only 
supports signing in.

Enter the requested information to create the super user, then
use those credentials to log in to the desktop application.
----------------------------------------------------------------
''');
  final credentials = await _promptUserCredentials();

  if (await _emailExists(credentials.email)) {
    stderr.writeln('\nEmail address is already in use: ${credentials.email}\n');
    return;
  }

  await _insertUserWithCredentials(credentials);

  stdout.writeln('''
\nSuper user created successfully.

After logging in, additional users can be created directly from the application interface.
''');
}

Future<bool> _emailExists(String email) async {
  // STUB IMPLEMENTATION
  return false;
}

Future<void> _insertUserWithCredentials(_Credentials credentials) async {
  // STUB IMPLEMENTATION
}

@immutable
final class _Credentials {
  const _Credentials({required this.email, required this.password});

  final String email;
  final String password;
}

Future<_Credentials> _promptUserCredentials() async {
  final email = promptInput(
    'Enter Email',
    allowEmpty: false,
    validateInput: (input) => EmailValidator.validate(input)
        ? null
        : 'Invalid email format. Provide a standard email address.',
  );

  final password = promptInput('Enter Password', allowEmpty: false);

  return _Credentials(email: email, password: password);
}
