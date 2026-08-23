import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/common/cubit_effect.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/login_identity/login_identity_service.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/user/models/server.dart';
import 'package:librelab_flutter/user/models/user.dart';
import 'package:librelab_shared/result.dart';
import 'package:logging/logging.dart';

part 'login_identity_state.dart';
part 'login_identity_effect.dart';
part 'login_identity_cubit.freezed.dart';

/// Manages locally configured login identities and the active authentication
/// session.
class LoginIdentityCubit({
  required final LoginIdentityService _service,
  required final Logger _logger,
  required final AuthRepository _authRepository,
}) extends CubitEffect<LoginIdentityState, LoginIdentityEffect> {
  this : super(const .initial());

  Future<void> load() async {
    emit(state.copyWith(loadState: const .loading()));

    try {
      final loginIdentities = await _service.read();
      _emitSuccessAndRestore(loginIdentities);
    } on Exception catch (e) {
      emit(state.copyWith(loadState: .failure(e)));
    }
  }

  Future<void> selectLoginIdentity(int loginIdentityId) async {
    // Intentionally avoids emitting a loading state since this is a fast local operation.

    try {
      final updatedLoginIdentities = await _service.selectLoginIdentity(
        loginIdentityId,
      );
      _emitSuccessAndRestore(updatedLoginIdentities);
    } on Exception catch (e) {
      emit(state.copyWith(loadState: .failure(e)));
    }
  }

  /// Logs out the currently selected login identity.
  ///
  /// If [confirmLogout] is `false`, emits a confirmation-required effect instead
  /// of logging out.
  Future<void> logout({bool confirmLogout = false}) async {
    final loadState = state.loadState;
    if (loadState is! LoadLoginIdentitiesSuccess) {
      throw StateError('Cannot logout when not already logged-in');
    }

    final selectedLoginIdentity = loadState.selectedLoginIdentity;
    if (selectedLoginIdentity == null) {
      throw StateError('Cannot logout without a selected login identity');
    }

    emit(state.copyWith(logoutState: const .loading()));

    final loginIsDisabledResult = await _authRepository.isLoginDisabled();

    switch (loginIsDisabledResult) {
      case SuccessResult(value: final isLoginDisabled):
        if (!confirmLogout) {
          emit(state.copyWith(logoutState: const .initial()));
          emitEffect(.confirmationRequired(isLoginDisabled: isLoginDisabled));
          return;
        }

        final loginIdentity = selectedLoginIdentity.loginIdentity;

        final requestResult = await _authRepository.logout(
          // Can be null on web
          refreshToken: loginIdentity.authTokens?.refreshToken.value,
        );

        switch (requestResult) {
          case SuccessResult(value: final tokenRevoked):
            _logger.info(
              'Successfully logged out user ${loginIdentity.user.id}: '
              '${tokenRevoked ? 'refresh token was found and revoked.' : 'refresh token was not found.'}',
            );

            try {
              final updatedLoginIdentities = await _service.removeLoginIdentity(
                loginIdentity.id,
              );
              _emitSuccessAndRestore(
                updatedLoginIdentities,
                logoutState: const .success(),
              );
            } on Exception catch (e, stackTrace) {
              _logger.shout(
                'Failed to remove the persisted user "${loginIdentity.user.id}" after logging out',
                e,
                stackTrace,
              );

              emit(state.copyWith(loadState: .failure(e)));
            }

          case FailureResult(:final failure):
            emit(state.copyWith(logoutState: .failure(failure)));
            emitEffect(.logoutFailureMessage(failure));
        }

      case FailureResult(:final failure):
        emit(state.copyWith(logoutState: .failure(failure)));
        emitEffect(.logoutFailureMessage(failure));
    }
  }

  /// For details, refer to the documentation comment of:
  /// [LoginIdentityService.completeLogin]
  Future<void> completeLogin({
    required Uri serverBaseUrl,
    required String labName,
    required User user,
    required AuthSession authSession,
    required bool persistAuthSession,
  }) async {
    emit(state.copyWith(loadState: const .loading()));

    try {
      final loginIdentities = await _service.completeLogin(
        serverBaseUrl: serverBaseUrl,
        labName: labName,
        user: user,
        authSession: authSession,
        persistAuthSession: persistAuthSession,
      );

      _emitSuccess(loginIdentities);
    } on Exception catch (e, stackTrace) {
      _logger.shout(
        'Failed to persist login of user "${user.id}" server "$serverBaseUrl"',
        e,
        stackTrace,
      );

      emit(state.copyWith(loadState: .failure(e)));
    }
  }

  void _emitSuccessAndRestore(
    LoginIdentities loginIdentities, {
    LogoutState? logoutState,
  }) {
    _service.restoreCurrentLoginIdentity(loginIdentities);
    _emitSuccess(loginIdentities, logoutState: logoutState);
  }

  void _emitSuccess(
    LoginIdentities loginIdentities, {
    LogoutState? logoutState,
  }) {
    final selected = _service.currentLoginIdentity(loginIdentities);

    final stateWithLogoutState = logoutState != null
        ? state.copyWith(logoutState: logoutState)
        : state;

    if (selected == null) {
      emit(
        stateWithLogoutState.copyWith(
          loadState: .success(
            loginIdentities: loginIdentities,
            selectedLoginIdentity: null,
          ),
        ),
      );
      return;
    }

    final (loginIdentity, server) = selected;

    emit(
      stateWithLogoutState.copyWith(
        loadState: .success(
          loginIdentities: loginIdentities,
          selectedLoginIdentity: .new(
            loginIdentity: loginIdentity,
            server: server,
          ),
        ),
      ),
    );
  }
}
