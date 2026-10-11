import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_handler.dart';
import 'package:librelab_flutter/file_storage/file_storage_repository.dart';
import 'package:librelab_flutter/lab_settings/cubit/lab_settings_cubit.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Provides the dependencies required by the lab settings feature.
///
/// Requires the following to be available in the widget tree:
///
/// - [LibreLabApiClient]
/// - [ApiRequestHandler]
/// - [FileStorageRepository]
class const LabSettingsDepsProvider({super.key})
    extends SingleChildStatelessWidget {
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return MultiProvider(
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
            fileStorageRepository: context.read<FileStorageRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
