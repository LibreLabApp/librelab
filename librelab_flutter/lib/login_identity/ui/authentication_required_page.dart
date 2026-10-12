import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/auth/login_cubit/login_cubit.dart';
import 'package:librelab_flutter/auth/ui/login_form_section.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/failure_view.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/login_identity/ui/login_identity_selector_menu_anchor.dart';
import 'package:material_ui/material_ui.dart';

/// A page shown when reauthentication is required for the selected login identity.
///
/// The user can reauthenticate the selected identity or switch to another
/// [LoginIdentity] where [LoginIdentity.reauthRequired] is `false`.
class const AuthenticationRequiredPage({super.key}) extends StatelessWidget {
  static const String routePath = '/authentication-required';

  @override
  Widget build(BuildContext context) {
    final loadState = context.select(
      (LoginIdentityCubit v) => v.state.loadState,
    );

    final t = context.t.authenticationRequiredPage;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const .symmetric(horizontal: 40),
          child: switch (loadState) {
            LoadLoginIdentitiesInitial() => const SizedBox.shrink(),
            LoadLoginIdentitiesLoading() => const CircularProgressIndicator(),
            LoadLoginIdentitiesSuccess(:final selectedLoginIdentity) =>
              _Content(
                selectedLoginIdentity:
                    selectedLoginIdentity ??
                    (throw StateError('A login identity must be selected')),
              ),
            LoadLoginIdentitiesFailure(:final exception) => FailureView(
              message: t.updateAccountFailure,
              onRetry: () => context.read<LoginIdentityCubit>().load(),
              technicalDetails: exception.toString(),
            ),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final SelectedLoginIdentity selectedLoginIdentity,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.textTheme;
    final t = context.t.authenticationRequiredPage;

    return Column(
      mainAxisAlignment: .center,
      children: [
        Text(t.title, style: textTheme.headlineSmall, textAlign: .center),
        const SizedBox(height: 12),
        Text(
          t.selectedLoginIdentityRequiresReauth,
          style: textTheme.bodyMedium,
          textAlign: .center,
        ),
        const SizedBox(height: 20),
        LoginFormSection(
          // Recreates the form when the selectedLoginIdentity changes.
          key: ValueKey(selectedLoginIdentity),
          serverBaseUrl: selectedLoginIdentity.server.apiBaseUrl,
          initialEmailText: selectedLoginIdentity.loginIdentity.user.email,
          emailTextFieldReadOnly: true,
          initialPersistAuthSessionValue:
              selectedLoginIdentity.loginIdentity.persistAuthSession,
          loginButtonSuccessBuilder: (_) {
            return FilledButton(
              onPressed: () {
                final loginCubit = context.read<LoginCubit>();
                final result = loginCubit.state.successOrThrow();
                final loginResult = result.result;

                // completeLogin() will update the existing login identity as the user
                // already exists.
                context.read<LoginIdentityCubit>().completeLogin(
                  serverBaseUrl: selectedLoginIdentity.server.apiBaseUrl,
                  labName: selectedLoginIdentity.server.name,
                  user: loginResult.user,
                  authSession: loginResult.authSession,
                  persistAuthSession: result.persistAuthSession,
                  onCompleted: (_) => loginCubit.resetState(),
                );
              },
              child: Text(t.continueButton),
            );
          },
        ),

        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(t.or, style: context.theme.textTheme.bodyMedium),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 20),
        LoginIdentitySelectorMenuAnchor(
          builder: (context, controller, _) => FilledButton(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            child: Text(
              context.t.loginIdentitySelectorMenuAnchor.switchAccount,
            ),
          ),
        ),
      ],
    );
  }
}
