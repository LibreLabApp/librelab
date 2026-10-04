import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/common/cubit_effect.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/common/ui/image_picker_handler.dart';
import 'package:librelab_flutter/file_storage/file_storage_repository.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_repository.dart';
import 'package:librelab_flutter/lab_settings/models/lab_settings.dart';
import 'package:librelab_shared/result.dart';

part 'lab_settings_state.dart';
part 'lab_settings_cubit.freezed.dart';
part 'lab_settings_effect.dart';

class LabSettingsCubit({
  required final LabSettingsRepository _labSettingsRepository,
  required final FileStorageRepository _fileStorageRepository,
}) extends CubitEffect<LabSettingsState, LabSettingsEffect> {
  this : super(const .initial());

  Future<void> fetch({required bool refresh}) async {
    if (state.fetchSettingsState is FetchSettingsLoading) {
      return;
    }
    if (!refresh && state.fetchSettingsState is FetchSettingsSuccess) {
      return;
    }

    emit(state.copyWith(fetchSettingsState: const .loading()));

    final result = await _labSettingsRepository.get();

    switch (result) {
      case SuccessResult(:final value):
        emit(state.copyWith(fetchSettingsState: .success(value)));

      case FailureResult(:final failure):
        emit(state.copyWith(fetchSettingsState: .failure(failure)));
    }
  }

  Future<void> update({
    required String labName,
    required LabImageUpdate labImageUpdate,
  }) async {
    final fetchSettingsState = state.fetchSettingsState;
    if (fetchSettingsState is! FetchSettingsSuccess) {
      throw StateError(
        'Cannot update settings before they have been successfully fetched.',
      );
    }

    if (state.updateSettingsState is UpdateSettingsLoading) {
      throw StateError(
        'Cannot update settings while an update is already in progress.',
      );
    }

    final oldSettings = fetchSettingsState.settings;

    emit(state.copyWith(updateSettingsState: const .loading()));

    String? newLabImageId;

    final shouldContinue = await _updateLabImage(
      oldSettings: oldSettings,
      labImageUpdate: labImageUpdate,
      onNewLabImageId: (id) => newLabImageId = id,
    );

    if (!shouldContinue) {
      return;
    }

    final result = await _labSettingsRepository.update(
      labName: labName,
      labImageId: newLabImageId,
    );

    switch (result) {
      case SuccessResult(value: final settings):
        emit(
          state.copyWith(
            updateSettingsState: const .success(),
            fetchSettingsState: .success(settings),
          ),
        );

        emitEffect(const .resetLabImageUpdate());

      case FailureResult(:final failure):
        emit(state.copyWith(updateSettingsState: .failure(failure)));
    }
  }

  /// Updates the lab image according to [labImageUpdate].
  ///
  /// Emits an update failure and returns `false` if the image update fails.
  /// Returns `true` if the lab settings update can continue.
  Future<bool> _updateLabImage({
    required LabSettings oldSettings,
    required LabImageUpdate labImageUpdate,
    required void Function(String id) onNewLabImageId,
  }) async {
    switch (labImageUpdate) {
      case KeepLabImage():
        // No-op
        return true;

      case RemoveLabImage():
        final labImageId = oldSettings.labImageId;

        if (labImageId == null) {
          return true;
        }

        // Deleting the storage object removes the lab image reference, so no
        // lab settings update is needed.
        final deleteResult = await _fileStorageRepository.delete(labImageId);

        switch (deleteResult) {
          case SuccessResult():
            // No-op
            return true;
          case FailureResult(:final failure):
            emit(state.copyWith(updateSettingsState: .failure(failure)));
            return false;
        }

      case ReplaceLabImage(:final pickedImage):
        final labImageId = oldSettings.labImageId;

        final fileUpload = FileUpload(
          stream: .value(pickedImage.bytes),
          length: pickedImage.length,
          filename: pickedImage.name,
          mimeType: pickedImage.mimeType,
        );

        if (labImageId == null) {
          final uploadResult = await _fileStorageRepository.upload(
            file: fileUpload,
            purpose: .labImage,
          );

          switch (uploadResult) {
            case SuccessResult(:final value):
              onNewLabImageId(value);
              return true;

            case FailureResult(:final failure):
              emit(state.copyWith(updateSettingsState: .failure(failure)));
              return false;
          }
        } else {
          final uploadResult = await _fileStorageRepository.update(
            id: labImageId,
            file: fileUpload,
          );

          switch (uploadResult) {
            case SuccessResult():
              // No-op
              return true;
            case FailureResult(:final failure):
              emit(state.copyWith(updateSettingsState: .failure(failure)));
              return false;
          }
        }
    }
  }
}

sealed class const LabImageUpdate();

final class const KeepLabImage() extends LabImageUpdate;
final class const RemoveLabImage() extends LabImageUpdate;

final class const ReplaceLabImage(final PickedImage pickedImage)
    extends LabImageUpdate;
