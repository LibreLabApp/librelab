import 'package:go_router/go_router.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/login_identity/ui/add_login_identity/add_login_identity_flow.dart';
import 'package:material_ui/material_ui.dart';

class const AddLoginIdentityPage({super.key}) extends StatelessWidget {
  static const String routePath = '/add-login-identity';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.addLoginIdentityPage.title),
        leading: BackButton(onPressed: context.pop),
      ),
      body: SafeArea(
        child: AddLoginIdentityFlow(
          startingStep: .serverSelection,
          onCompleted: context.pop,
        ),
      ),
    );
  }
}
