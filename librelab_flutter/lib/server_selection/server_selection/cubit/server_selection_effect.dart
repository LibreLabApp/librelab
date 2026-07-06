part of 'server_selection_cubit.dart';

@immutable
@freezed
sealed class ServerSelectionEffect with _$ServerSelectionEffect {
  const factory focusServerAddress() = FocusServerAddress;
  const factory showServerSelectionRequired() = ShowServerSelectionRequired;
}
