import 'package:librelab_flutter/login_identity/ui/add_login_identity/add_login_identity_flow.dart';
import 'package:material_ui/material_ui.dart' hide Step;

class const InitialSetupPage({super.key}) extends StatelessWidget {
  static const String routePath = '/initial-setup';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AddLoginIdentityFlow(startingStep: .preferences)),
    );
  }
}
