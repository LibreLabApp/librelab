import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_api_client/librelab_api_client.dart';
import 'package:librelab_flutter/login_identity/cubit/login_identity_cubit.dart';
import 'package:provider/single_child_widget.dart';

/// Provides the dependencies required by the login identity feature.
///
/// Requires a [LibreLabApiClient] to be available in the widget tree.
class const LoginIdentityDepsProvider({
  required final LoginIdentityCubit loginIdentityCubit,
  super.key,
}) extends SingleChildStatelessWidget {
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return BlocProvider.value(value: loginIdentityCubit, child: child);
  }
}
