// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
  locale: $enumDecodeNullable(_$AppLocaleEnumMap, json['locale']),
  appearance: AppAppearance.fromJson(
    json['appearance'] as Map<String, dynamic>,
  ),
  telemetry: TelemetrySettings.fromJson(
    json['telemetry'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'locale': _$AppLocaleEnumMap[instance.locale],
      'appearance': instance.appearance,
      'telemetry': instance.telemetry,
    };

const _$AppLocaleEnumMap = {AppLocale.en: 'en', AppLocale.ar: 'ar'};

AppAppearance _$AppAppearanceFromJson(Map<String, dynamic> json) =>
    AppAppearance(
      themeMode:
          $enumDecodeNullable(_$AppThemeModeEnumMap, json['themeMode']) ??
          AppThemeMode.system,
      useSystemColors: json['useSystemColors'] as bool? ?? true,
      useAccentColor: json['useAccentColor'] as bool? ?? false,
      accentColor: (json['accentColor'] as num?)?.toInt() ?? 4294922834,
      useAnimatedGraphics: json['useAnimatedGraphics'] as bool? ?? true,
    );

Map<String, dynamic> _$AppAppearanceToJson(AppAppearance instance) =>
    <String, dynamic>{
      'themeMode': _$AppThemeModeEnumMap[instance.themeMode]!,
      'useSystemColors': instance.useSystemColors,
      'useAccentColor': instance.useAccentColor,
      'accentColor': instance.accentColor,
      'useAnimatedGraphics': instance.useAnimatedGraphics,
    };

const _$AppThemeModeEnumMap = {
  AppThemeMode.system: 'system',
  AppThemeMode.dark: 'dark',
  AppThemeMode.light: 'light',
};

TelemetrySettings _$TelemetrySettingsFromJson(Map<String, dynamic> json) =>
    TelemetrySettings(
      sendCrashReports: json['sendCrashReports'] as bool? ?? false,
    );

Map<String, dynamic> _$TelemetrySettingsToJson(TelemetrySettings instance) =>
    <String, dynamic>{'sendCrashReports': instance.sendCrashReports};
