import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  @override
  @doNotGenerate
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    // This function will never be executed if @doNotGenerate annotation is used and
    // generated Serverpod is up to date.

    // In case the annotation is removed or the generated code is outdated,
    // the server should crash to indicate a critical security bug
    // and to disallow users from signing up.

    // Fallback guard (added to satisfy the Dart compiler):
    // In case "@doNotGenerate" annotation is not present or not working.
    await session.server.shutdown();
    throw UnimplementedError(
      'CRITICAL SECURITY BUG: startRegistration was executed. '
      'Account registration must never be reachable. '
      'Check @doNotGenerate configuration and code generation setup.',
    );
  }
}
