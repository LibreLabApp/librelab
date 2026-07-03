// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/common/json_types.dart';

part 'app_settings.g.dart';
part 'app_settings.freezed.dart';

enum AppLocale() {
  en,
  ar;
}

@immutable
@Freezed(fromJson: false, toJson: false)
@JsonSerializable()
class const AppSettings({
  /// Set to `null` to use the system default
  @JsonKey(defaultValue: null) required final AppLocale? locale,
  required final AppAppearance appearance,
  required final TelemetrySettings telemetry,
}) with _$AppSettings {
  // TODO: (in librelab_server) Review AppConfig, AppSecrets, and LabSettings and ensure consistency with this file
  /// Pass `null` to use the default values
  factory fromJsonWithDefaults(JsonMap? json) {
    final JsonMap map = json ?? emptyJson;

    return AppSettings.fromJson({
      'locale': map['locale'],
      'appearance': map['appearance'] ?? emptyJson,
      'telemetry': map['telemetry'] ?? emptyJson,
    });
  }

  factory fromJson(JsonMap json) => _$AppSettingsFromJson(json);
  JsonMap toJson() => _$AppSettingsToJson(this);
}

enum AppThemeMode { system, dark, light }

@immutable
@Freezed(fromJson: false, toJson: false)
@JsonSerializable()
class const AppAppearance({
  @JsonKey(defaultValue: AppThemeMode.system)
  required final AppThemeMode themeMode,
  @JsonKey(defaultValue: true) required final bool useSystemColors,

  @JsonKey(defaultValue: false) required final bool useAccentColor,

  /// Stored as ARGB int
  @JsonKey(defaultValue: 0xFFFF5252) // Colors.redAccent
  required final int accentColor,
}) with _$AppAppearance {
  factory fromJson(JsonMap json) => _$AppAppearanceFromJson(json);
  JsonMap toJson() => _$AppAppearanceToJson(this);
}

@immutable
@Freezed(fromJson: false, toJson: false)
@JsonSerializable()
class const TelemetrySettings({
  @JsonKey(defaultValue: false) required final bool sendCrashReports,
}) with _$TelemetrySettings {
  factory fromJson(JsonMap json) => _$TelemetrySettingsFromJson(json);
  JsonMap toJson() => _$TelemetrySettingsToJson(this);
}
