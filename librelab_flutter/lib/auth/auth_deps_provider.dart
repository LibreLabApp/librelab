import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/auth/login_cubit/login_cubit.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:logging/logging.dart';

/// Provides the dependencies required by the authentication feature.
///
/// Requires a [LibreLabApiClient] and an [ApiRequestHandler] to be available
/// in the widget tree.
class const AuthDepsProvider({
  super.key,
  required final Widget child,
  required final AuthRepository _authRepository,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider.value(value: _authRepository),
        BlocProvider(
          create: (context) => LoginCubit(
            authRepository: context.read<AuthRepository>(),
            client: context.read<LibreLabApiClient>(),
            logger: Logger('LoginCubit'),
          ),
        ),
      ],
      child: child,
    );
  }
}
