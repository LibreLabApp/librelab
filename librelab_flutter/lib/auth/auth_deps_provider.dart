import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/auth/auth_repository/auth_repository.dart';
import 'package:librelab_flutter/auth/cubit/login_cubit.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';

/// Provides the dependencies required by the authentication feature.
///
/// Requires a [LibreLabApiClient] and an [ApiRequestHandler] to be available
/// in the widget tree.
class const AuthDepsProvider({required final Widget child, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authEndpoints: context.read<LibreLabApiClient>().endpoints.auth,
            handler: context.read<ApiRequestHandler>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              LoginCubit(authRepository: context.read<AuthRepository>()),
        ),
      ],
      child: child,
    );
  }
}
