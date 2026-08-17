import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/common/network/api_client/api_request_failures.dart';
import 'package:librelab_flutter/lab_settings/lab_settings_repository.dart';
import 'package:librelab_flutter/lab_settings/models/lab_settings.dart';
import 'package:librelab_shared/result.dart';

part 'lab_settings_state.dart';
part 'lab_settings_cubit.freezed.dart';

class LabSettingsCubit({
  required final LabSettingsRepository _labSettingsRepository,
}) extends Cubit<LabSettingsState> {
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

  Future<void> update({required String labName}) async {
    if (state.fetchSettingsState is! FetchSettingsSuccess) {
      throw StateError(
        'Cannot update settings before they have been successfully fetched.',
      );
    }

    if (state.updateSettingsState is UpdateSettingsLoading) {
      throw StateError(
        'Cannot update settings while an update is already in progress.',
      );
    }

    emit(state.copyWith(updateSettingsState: const .loading()));

    final result = await _labSettingsRepository.update(labName: labName);

    switch (result) {
      case SuccessResult(value: final settings):
        emit(
          state.copyWith(
            updateSettingsState: const .success(),
            fetchSettingsState: .success(settings),
          ),
        );

      case FailureResult(:final failure):
        emit(state.copyWith(updateSettingsState: .failure(failure)));
    }
  }
}
