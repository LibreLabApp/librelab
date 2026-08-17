import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/lab_settings/cubit/lab_settings_cubit.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_repository.dart';

/// Provides the dependencies required by the lab settings feature.
///
/// Requires a [LibreLabApiClient] and an [ApiRequestHandler] to be available
/// in the widget tree.
class const LabSettingsDepsProvider({required final Widget child, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider(
          create: (context) => LabSettingsRepository(
            labSettingsEndpoints: context
                .read<LibreLabApiClient>()
                .endpoints
                .labSettings,
            handler: context.read<ApiRequestHandler>(),
          ),
        ),
        BlocProvider(
          create: (context) => LabSettingsCubit(
            labSettingsRepository: context.read<LabSettingsRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
