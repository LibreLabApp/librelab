import 'dart:io';

import 'package:librelab_server/src/utils/cli_input.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Creates an admin user if there is no one in the database, which is required to log in to the desktop app.
///
/// If there is no admin user, the program will prompt in the command-line
/// to create the admin account credentials. If the input is invalid or empty, the server will terminate.
///
/// Returns whether a new user was created or not.
Future<bool> ensureHasAdminUser(Session session) async {
  final exists = (await AuthUser.db.count(session, limit: 1)) >= 1;
  if (exists) {
    return false;
  }

  await createAdminUser(session);

  return true;
}

Future<void> createAdminUser(Session session) async {
  stdout.writeln('''
================================================================
  SYSTEM SETUP: ADMIN CREATION
================================================================
To access the desktop application, at least one administrator
must exist to manage the server, as the application only 
supports signing in.

Enter the requested information to create the admin user, then
use those credentials to log in to the desktop application.
----------------------------------------------------------------
''');
  final credentials = await _promptUserCredentials();

  if (await _emailExists(session, credentials.email)) {
    stderr.writeln('\nEmail address is already in use: ${credentials.email}\n');
    return;
  }

  await _insertUserWithCredentials(credentials, session);

  stdout.writeln('''
\nAdmin user created successfully.

After logging in, additional users can be created directly from the application interface.
''');
}

Future<bool> _emailExists(Session session, String email) async {
  return (await EmailAccount.db.count(
        session,
        where: (account) => account.email.equals(email),
      )) >=
      1;
}

Future<void> _insertUserWithCredentials(
  _Credentials credentials,
  Session session,
) async {
  final authServices = AuthServices.instance;

  final user = await authServices.authUsers.create(
    session,
    scopes: {Scope.admin},
  );
  await authServices.emailIdp.admin.createEmailAuthentication(
    session,
    authUserId: user.id,
    email: credentials.email,
    password: credentials.password,
  );
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
