import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/login_identity/login_identity_service.dart';
import 'package:librelab_flutter/login_identity/models/login_identities.dart';
import 'package:librelab_flutter/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/user/models/server.dart';
import 'package:librelab_flutter/user/models/user.dart';
import 'package:logging/logging.dart';

part 'login_identity_state.dart';
part 'login_identity_cubit.freezed.dart';

/// Manages locally configured login identities and the active authentication
/// session.
class LoginIdentityCubit({
  required final LoginIdentityService _service,
  required final Logger _logger,
}) extends Cubit<LoginIdentityState> {
  this : super(const .initial());

  Future<void> load() async {
    emit(const .loading());

    try {
      final loginIdentities = await _service.read();
      _emitSuccessAndRestore(loginIdentities);
    } on Exception catch (e) {
      emit(.failure(e));
    }
  }

  Future<void> selectLoginIdentity(int loginIdentityId) async {
    emit(const .loading());

    try {
      final loginIdentities = await _service.selectLoginIdentity(
        loginIdentityId,
      );
      _emitSuccessAndRestore(loginIdentities);
    } on Exception catch (e) {
      emit(.failure(e));
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
    emit(const .loading());

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
        'Failed to complete login for user "${user.id}" server "$serverBaseUrl"',
        e,
        stackTrace,
      );

      emit(.failure(e));
    }
  }

  void _emitSuccessAndRestore(LoginIdentities loginIdentities) {
    _service.restoreCurrentLoginIdentity(loginIdentities);
    _emitSuccess(loginIdentities);
  }

  void _emitSuccess(LoginIdentities loginIdentities) {
    final (selected) = _service.currentLoginIdentity(loginIdentities);

    if (selected == null) {
      emit(
        .success(loginIdentities: loginIdentities, selectedLoginIdentity: null),
      );
      return;
    }

    final (loginIdentity, server) = selected;

    emit(
      .success(
        loginIdentities: loginIdentities,
        selectedLoginIdentity: .new(
          loginIdentity: loginIdentity,
          server: server,
        ),
      ),
    );
  }
}
