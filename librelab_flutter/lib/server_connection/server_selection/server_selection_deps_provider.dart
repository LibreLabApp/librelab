import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/cubit/local_discovery_cubit.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/local_discovery_repository.dart';
import 'package:librelab_flutter/server_connection/server_selection/local_network_discovery/mdns_service_discovery_resolver.dart';
import 'package:librelab_flutter/server_connection/server_selection/server_selection/cubit/server_selection_cubit.dart';
import 'package:logging/logging.dart';
import 'package:mdns_discovery/mdns_discovery.dart';

class ServerSelectionDepsProvider extends StatefulWidget {
  const ServerSelectionDepsProvider({super.key, required this.child});

  final Widget child;

  @override
  State<ServerSelectionDepsProvider> createState() =>
      _ServerSelectionDepsProviderState();
}

class _ServerSelectionDepsProviderState
    extends State<ServerSelectionDepsProvider> {
  late Future<MdnsServiceDiscovery> _future;

  @override
  void initState() {
    _future = resolveMdnsServiceDiscoveryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return const SizedBox.shrink();
        }
        final discovery = asyncSnapshot.requireData;
        return MultiBlocProvider(
          providers: [
            RepositoryProvider(
              create: (context) => LocalDiscoveryRepository(
                logger: Logger('$LocalDiscoveryRepository'),
                discovery: discovery,
              ),
              dispose: (repository) => repository.close(),
            ),
            BlocProvider(
              create: (context) => LocalDiscoveryCubit(
                localDiscoveryRepository: context
                    .read<LocalDiscoveryRepository>(),
              ),
            ),
            BlocProvider(create: (context) => ServerSelectionCubit()),
          ],
          child: widget.child,
        );
      },
    );
  }
}
