import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/app_settings/app_settings.dart';
import 'package:librelab_flutter/app_settings/app_settings_repository.dart';

part 'app_settings_state.dart';
part 'app_settings_cubit.freezed.dart';

class AppSettingsCubit(
  final AppSettingsRepository _repository, {
  required AppSettings initial,
}) extends Cubit<AppSettingsState> {
  this : super(.new(initial));

  Future<void> update(AppSettings updated) async {
    await _repository.save(updated);
    emit(state.copyWith(settings: updated));
  }
}
