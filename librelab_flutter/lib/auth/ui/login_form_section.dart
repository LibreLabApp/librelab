import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/auth/auth_repository/login_failures.dart';
import 'package:librelab_flutter/auth/auth_repository/login_result.dart';
import 'package:librelab_flutter/auth/login_cubit/login_cubit.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/text_field_state.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/common/ui/widgets/api_request_failure_card.dart';
import 'package:librelab_flutter/common/ui/widgets/button_loading_indicator.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:librelab_shared/result.dart' hide Failure;
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class const LoginFormSection({super.key, required final Uri serverBaseUrl})
    extends StatefulWidget {
  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final _formKey = GlobalKey<FormState>();

  final _emailState = TextFieldState();
  final _passwordState = TextFieldState();
  bool _persistAuthSession = true;

  @override
  void initState() {
    final state = context.read<LoginCubit>().state;
    if (state is Success) {
      _persistAuthSession = state.persistAuthSession;
    }

    super.initState();
  }

  @override
  void dispose() {
    _emailState.dispose();
    _passwordState.dispose();
    super.dispose();
  }

  void _login() {
    final formState =
        _formKey.currentState ??
        (throw StateError('Form state is not available'));
    if (!formState.validate()) {
      return;
    }

    context.read<LoginCubit>().login(
      email: _emailState.controller.text,
      password: _passwordState.controller.text,
      serverBaseUrl: widget.serverBaseUrl,
      persistAuthSession: _persistAuthSession,
    );
  }

  (String? emailError, String? passwordError) _getErrorMessage(
    LoginFailure? failure,
  ) {
    final t = context.t.loginFormSection.loginFailures;

    return switch (failure) {
      null => (null, null),
      InvalidLoginCredentialsFailure() => (
        t.invalidCredentials,
        t.invalidCredentials,
      ),
      LoginDisabledFailure() => (t.loginDisabled, null),
      InvalidLoginInputFailure() => (t.invalidInput, t.invalidInput),
    };
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.loginFormSection;

    return Form(
      key: _formKey,
      autovalidateMode: .onUserInteraction,
      child: Column(
        children: [
          BlocSelector<LoginCubit, LoginState, LoginFailure?>(
            selector: (state) => (state is Failure) ? state.failure : null,
            builder: (context, failure) {
              final (emailError, passwordError) = _getErrorMessage(failure);

              return Column(
                children: [
                  _EmailAddressTextField(
                    controller: _emailState.controller,
                    focusNode: _emailState.focusNode,
                    onFieldSubmitted: (_) =>
                        _passwordState.focusNode.requestFocus(),
                    errorText: emailError,
                  ),
                  const SizedBox(height: 16),
                  _PasswordTextField(
                    controller: _passwordState.controller,
                    focusNode: _passwordState.focusNode,
                    onFieldSubmitted: (_) => _login(),
                    errorText: passwordError,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 8),
          if (kIsWeb)
            const _GuestModeNotice()
          else
            CheckboxListTile(
              value: _persistAuthSession,
              onChanged: (value) =>
                  setState(() => _persistAuthSession = value ?? true),
              title: Text(t.persistAuthSession),
              controlAffinity: .leading,
              contentPadding: .zero,
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: .infinity,
            height: 40,
            child: BlocSelector<LoginCubit, LoginState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return FilledButton(
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? const ButtonLoadingIndicator()
                      : Text(t.loginButton),
                );
              },
            ),
          ),
          BlocSelector<LoginCubit, LoginState, bool>(
            selector: (state) =>
                state.isSuccess || state.isRequestFailure || state.isLoading,
            builder: (context, hide) {
              if (hide) {
                return const SizedBox.shrink();
              }
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: _LoginCredentialsGuide(),
              );
            },
          ),
          const SizedBox(height: 32),
          BlocSelector<
            LoginCubit,
            LoginState,
            Either<LoginResultSuccess, ApiRequestFailure>?
          >(
            selector: (state) {
              if (state is Success) {
                return .left(state.result);
              }
              if (state is RequestFailure) {
                return .right(state.failure);
              }

              return null;
            },
            builder: (context, either) {
              if (either == null) {
                return const SizedBox.shrink();
              }
              return switch (either) {
                EitherLeft(leftValue: final success) => AlertCard(
                  type: .success,
                  prefixIcon: Icons.check_circle_outline_rounded,
                  suffix: (color) => Row(
                    mainAxisSize: .min,
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: color,
                        child: Text(
                          success.user.fullName.characters.first.toUpperCase(),
                          style: context.theme.textTheme.labelLarge?.copyWith(
                            color: context.theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => context.read<LoginCubit>().logout(),
                        child: Text(t.loginSuccess.logout),
                      ),
                    ],
                  ),
                  title: Text(t.loginSuccess.title),
                  subtitle: Text.rich(
                    TextSpan(
                      text: t.loginSuccess.subtitle(fullName: ''),
                      children: [
                        TextSpan(
                          text: success.user.fullName,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                EitherRight(rightValue: final failure) => ApiRequestFailureCard(
                  title: t.requestFailureTitle,
                  failure: failure,
                ),
              };
            },
          ),
        ],
      ),
    );
  }
}

class const _EmailAddressTextField({
  required final TextEditingController _controller,
  required final FocusNode _focusNode,
  required final ValueChanged<String> onFieldSubmitted,
  required final String? errorText,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t.loginFormSection.emailAddressTextField;

    return TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: 1,
      textCapitalization: .none,
      keyboardType: .emailAddress,
      textInputAction: .next,
      autocorrect: false,
      enableSuggestions: false,
      autofillHints: const [AutofillHints.email],
      validator: (value) {
        final validationErrorMessages = t.validationErrors;

        final input = value?.trim();

        if (input == null || input.isEmpty) {
          return validationErrorMessages.emptyInput;
        }

        if (!AuthInputRules.isEmailFormatValid(input)) {
          return validationErrorMessages.invalidEmailAddress;
        }

        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        border: const OutlineInputBorder(),
        labelText: t.label,
        hintText: t.hint,
        errorText: errorText,
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

class const _PasswordTextField({
  required final TextEditingController _controller,
  required final FocusNode _focusNode,
  required final ValueChanged<String> onFieldSubmitted,
  required final String? errorText,
}) extends StatefulWidget {
  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.loginFormSection.passwordTextField;

    return TextFormField(
      controller: widget._controller,
      focusNode: widget._focusNode,
      maxLines: 1,
      textCapitalization: .none,
      keyboardType: .text,
      textInputAction: .done,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: !_passwordVisible,
      autofillHints: const [AutofillHints.password],
      validator: (value) {
        final validationErrorMessages = t.validationErrors;

        final input = value?.trim();

        if (input == null || input.isEmpty) {
          return validationErrorMessages.emptyInput;
        }

        if (!AuthInputRules.isPasswordLengthValid(input)) {
          return validationErrorMessages.invalidLength;
        }

        return null;
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          tooltip: _passwordVisible ? t.visibility.hide : t.visibility.show,
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
        ),
        prefixIcon: const Icon(Icons.lock_outline),
        border: const OutlineInputBorder(),
        labelText: t.label,
        errorText: widget.errorText,
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}

/// A notice for browser platforms explaining how to use Guest mode
/// when signing in on a device that is not the user's own.
class const _GuestModeNotice() extends StatelessWidget {
  static const String _link =
      'https://support.google.com/chrome/answer/6130773';
  static final Uri _uri = Uri.parse(_link);

  @override
  Widget build(BuildContext context) {
    final t = context.t.loginFormSection.browserGuestModeNotice;

    return Text.rich(
      TextSpan(
        text: '${t.text} ',
        children: [
          TextSpan(
            text: t.learnMore,
            style: const TextStyle(decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                await launchUrl(_uri);
              },
          ),
        ],
      ),
    );
  }
}

/// Provides information about obtaining login credentials.
///
/// Unauthorized users cannot register accounts directly in the app. The server prompts
/// the administrator to create the initial superuser, who can then create
/// additional users.
///
/// This widget explains this login model to the end user.
class const _LoginCredentialsGuide() extends StatefulWidget {
  @override
  State<_LoginCredentialsGuide> createState() => _LoginCredentialsGuideState();
}

class _LoginCredentialsGuideState extends State<_LoginCredentialsGuide> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.loginFormSection.loginCredentialsGuide;

    final theme = context.theme;
    final (colorScheme, textTheme) = (theme.colorScheme, theme.textTheme);

    return Column(
      crossAxisAlignment: .start,
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          borderRadius: .circular(8),
          child: Padding(
            padding: const .symmetric(vertical: 8, horizontal: 4),
            child: Row(
              mainAxisSize: .min,
              children: [
                Icon(Icons.help_outline, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  t.label,
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: .w500,
                    decorationColor: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 18,
                  color: colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const .new(milliseconds: 300),
          curve: Curves.easeOut,
          child: _expanded
              ? Padding(
                  padding: const .only(left: 32, right: 8, top: 2, bottom: 8),
                  child: Text(t.description, style: textTheme.bodyMedium),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
