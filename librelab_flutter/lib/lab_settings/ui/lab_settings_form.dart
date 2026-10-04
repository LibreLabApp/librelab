import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/build_context_ext.dart';
import 'package:librelab_flutter/common/ui/librelab/librelab_storage_image_provider.dart';
import 'package:librelab_flutter/common/ui/widgets/button_loading_indicator.dart';
import 'package:librelab_flutter/common/ui/widgets/cubit_effect_listener.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/api_request_failure_card.dart';
import 'package:librelab_flutter/common/ui/widgets/failure/api_request_failure_view.dart';
import 'package:librelab_flutter/common/ui/widgets/image_picker_field.dart';
import 'package:librelab_flutter/common/ui/widgets/loading_message.dart';
import 'package:librelab_flutter/file_storage/file_storage_repository.dart';
import 'package:librelab_flutter/lab_settings/cubit/lab_settings_cubit.dart';
import 'package:librelab_flutter/lab_settings/models/lab_settings.dart';
import 'package:material_ui/material_ui.dart';

class const LabSettingsForm({
  super.key,
  required final bool _hasPermissionToUpdate,
}) extends StatefulWidget {
  @override
  State<LabSettingsForm> createState() => _LabSettingsFormState();
}

class _LabSettingsFormState extends State<LabSettingsForm> {
  final _formKey = GlobalKey<FormState>();

  final _labNameController = TextEditingController();
  String? _fallbackCharacter;

  LabImageUpdate _labImageUpdate = const KeepLabImage();

  void fetch({required bool refresh}) =>
      context.read<LabSettingsCubit>().fetch(refresh: refresh);

  @override
  void initState() {
    final fetchState = context
        .read<LabSettingsCubit>()
        .state
        .fetchSettingsState;

    if (fetchState case FetchSettingsSuccess(:final settings)) {
      _updateFormFromSettings(settings);
    }

    fetch(refresh: false);
    super.initState();
  }

  @override
  void dispose() {
    _labNameController.dispose();
    super.dispose();
  }

  void _update() {
    final formState =
        _formKey.currentState ??
        (throw StateError('Form state is not available'));
    if (!formState.validate()) {
      return;
    }

    context.read<LabSettingsCubit>().update(
      labName: _labNameController.text,
      labImageUpdate: _labImageUpdate,
    );
  }

  void _updateFormFromSettings(LabSettings settings) {
    final labName = settings.labName;

    _labNameController.text = labName ?? '';
    _fallbackCharacter = labName?.characters.firstOrNull?.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.labSettingsForm;

    final fetchState = context.select(
      (LabSettingsCubit v) => v.state.fetchSettingsState,
    );

    return _LabSettingsEffectListener(
      onLabImageUpdateReset: () =>
          setState(() => _labImageUpdate = const KeepLabImage()),
      child: _LabSettingsLoadedListener(
        onSettingsLoaded: (settings) =>
            setState(() => _updateFormFromSettings(settings)),
        child: switch (fetchState) {
          FetchSettingsInitial() => const SizedBox.shrink(),
          FetchSettingsLoading() => Padding(
            padding: const EdgeInsets.only(top: 92),
            child: LoadingMessage(message: t.fetch.loadingMessage),
          ),
          FetchSettingsSuccess(:final settings) => Form(
            key: _formKey,
            autovalidateMode: .onUserInteraction,
            child: Column(
              children: [
                ImagePickerField(
                  fallbackCharacter:
                      _fallbackCharacter ?? context.t.questionMark,
                  image: switch (_labImageUpdate) {
                    ReplaceLabImage(:final pickedImage) => MemoryImage(
                      pickedImage.bytes,
                    ),
                    RemoveLabImage() => null,
                    KeepLabImage() => switch (settings.labImageId) {
                      final labImageId? => LibreLabStorageImage(
                        storageObjectId: labImageId,
                        updatedAt: settings.updatedAt,
                        fileStorageRepository: context
                            .read<FileStorageRepository>(),
                      ),
                      null => null,
                    },
                  },
                  onImagePicked: (pickedImage) => setState(
                    () => _labImageUpdate = ReplaceLabImage(pickedImage),
                  ),
                  onImageRemoved: () =>
                      setState(() => _labImageUpdate = const RemoveLabImage()),
                  canEdit: widget._hasPermissionToUpdate,
                ),
                const SizedBox(height: 48),
                _LabNameTextField(
                  readOnly: !widget._hasPermissionToUpdate,
                  controller: _labNameController,
                  onFieldSubmitted: (_) => _update(),
                  onChanged: (value) {
                    final firstCharacter = value.characters.firstOrNull
                        ?.toUpperCase();

                    if (_fallbackCharacter != firstCharacter) {
                      setState(() => _fallbackCharacter = firstCharacter);
                    }
                  },
                  labNameMissingWithoutUpdatePermission:
                      !widget._hasPermissionToUpdate &&
                      settings.labName == null,
                ),
                const SizedBox(height: 24),
                BlocSelector<LabSettingsCubit, LabSettingsState, bool>(
                  selector: (state) =>
                      state.updateSettingsState is UpdateSettingsLoading,
                  builder: (context, isUpdating) {
                    return Column(
                      children: [
                        if (widget._hasPermissionToUpdate)
                          SizedBox(
                            width: .infinity,
                            height: 40,
                            child: FilledButton(
                              onPressed: isUpdating ? null : _update,
                              child: isUpdating
                                  ? const ButtonLoadingIndicator()
                                  : Text(t.updateButton),
                            ),
                          ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: .infinity,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: isUpdating
                                ? null
                                : () => fetch(refresh: true),
                            child: Text(t.refreshButton),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                BlocSelector<
                  LabSettingsCubit,
                  LabSettingsState,
                  ApiRequestFailure?
                >(
                  selector: (state) {
                    final updateState = state.updateSettingsState;
                    return updateState is UpdateSettingsFailure
                        ? updateState.failure
                        : null;
                  },
                  builder: (context, failure) {
                    if (failure == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ApiRequestFailureCard(
                        title: t.updateFailureMessage,
                        failure: failure,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          FetchSettingsFailure(:final failure) => ApiRequestFailureView(
            title: t.fetch.failureTitle,
            failure: failure,
            onRetry: () => fetch(refresh: true),
          ),
        },
      ),
    );
  }
}

class const _LabNameTextField({
  required final TextEditingController _controller,
  required final ValueChanged<String> _onFieldSubmitted,
  required final ValueChanged<String> _onChanged,
  required final bool _readOnly,

  /// Whether the lab name is missing and the logged-in user lacks permission to update it.
  required final bool _labNameMissingWithoutUpdatePermission,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = context.t.labSettingsForm.labNameTextField;

    return TextFormField(
      readOnly: _readOnly,
      controller: _controller,
      maxLines: 1,
      textCapitalization: .words,
      keyboardType: .text,
      textInputAction: .done,
      autofillHints: const [AutofillHints.organizationName],
      validator: _readOnly
          ? null
          : (value) {
              final validationErrorMessages = t.validationErrors;

              final input = value?.trim();

              if (input == null || input.isEmpty) {
                return validationErrorMessages.emptyInput;
              }

              return null;
            },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.business),
        border: const OutlineInputBorder(),
        labelText: t.label,
        hintText: t.hint,
        helperMaxLines: _labNameMissingWithoutUpdatePermission ? 6 : null,
        helperText: _labNameMissingWithoutUpdatePermission
            ? context
                  .t
                  .labSettingsForm
                  .labNameMissingWithoutUpdatePermissionMessage
            : null,
      ),
      onFieldSubmitted: _onFieldSubmitted,
      onChanged: _onChanged,
    );
  }
}

/// Calls [onSettingsLoaded] when lab settings are successfully loaded.
class const _LabSettingsLoadedListener({
  required final Widget child,
  required final void Function(LabSettings settings) onSettingsLoaded,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LabSettingsCubit, LabSettingsState>(
      listenWhen: (previous, current) =>
          previous.fetchSettingsState is! FetchSettingsSuccess &&
          current.fetchSettingsState is FetchSettingsSuccess,
      listener: (context, state) {
        final success = state.fetchSettingsState as FetchSettingsSuccess;

        onSettingsLoaded(success.settings);
      },
      child: child,
    );
  }
}

/// Handles lab settings effects that require local form state updates.
class const _LabSettingsEffectListener({
  required final VoidCallback onLabImageUpdateReset,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitEffectListener<
      LabSettingsCubit,
      LabSettingsState,
      LabSettingsEffect
    >(
      listener: (context, effect) {
        switch (effect) {
          case ResetLabImageUpdate():
            onLabImageUpdateReset();
        }
      },
      child: child,
    );
  }
}
