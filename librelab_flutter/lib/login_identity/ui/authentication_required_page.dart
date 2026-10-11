import 'package:librelab_flutter/login_identity/models/login_identity.dart';
import 'package:material_ui/material_ui.dart';

/// A page shown when the selected login identity needs reauthentication.
///
/// The user can reauthenticate the selected identity or switch to another
/// [LoginIdentity] where [LoginIdentity.reauthRequired] is `false`.
class const AuthenticationRequiredPage({super.key}) extends StatelessWidget {
  static const String routePath = '/authentication-required';

  @override
  Widget build(BuildContext context) {
    // TODO: Implement (use LoginIdentitySelectorMenuAnchor and LoginFormSection)
    return const Scaffold(body: Column(children: [Text('Work in progress')]));
  }
}
