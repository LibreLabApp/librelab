// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

/// Set to `null` to use the system default
@JsonKey(defaultValue: null) AppLocale? get locale; AppAppearance get appearance; TelemetrySettings get telemetry;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.telemetry, telemetry) || other.telemetry == telemetry));
}


@override
int get hashCode => Object.hash(runtimeType,locale,appearance,telemetry);

@override
String toString() {
  return 'AppSettings(locale: $locale, appearance: $appearance, telemetry: $telemetry)';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(defaultValue: null) AppLocale? locale, AppAppearance appearance, TelemetrySettings telemetry
});


$AppAppearanceCopyWith<$Res> get appearance;$TelemetrySettingsCopyWith<$Res> get telemetry;

}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = freezed,Object? appearance = null,Object? telemetry = null,}) {
  return _then(AppSettings(
locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as AppLocale?,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as AppAppearance,telemetry: null == telemetry ? _self.telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as TelemetrySettings,
  ));
}
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppAppearanceCopyWith<$Res> get appearance {
  
  return $AppAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelemetrySettingsCopyWith<$Res> get telemetry {
  
  return $TelemetrySettingsCopyWith<$Res>(_self.telemetry, (value) {
    return _then(_self.copyWith(telemetry: value));
  });
}
}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: null)  AppLocale? locale,  AppAppearance appearance,  TelemetrySettings telemetry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.locale,_that.appearance,_that.telemetry);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: null)  AppLocale? locale,  AppAppearance appearance,  TelemetrySettings telemetry)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.locale,_that.appearance,_that.telemetry);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(defaultValue: null)  AppLocale? locale,  AppAppearance appearance,  TelemetrySettings telemetry)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.locale,_that.appearance,_that.telemetry);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings extends AppSettings {
  const _AppSettings({@JsonKey(defaultValue: null) required this.locale, required this.appearance, required this.telemetry}): super(locale: locale, appearance: appearance, telemetry: telemetry);
  

/// Set to `null` to use the system default
@override@JsonKey(defaultValue: null) final  AppLocale? locale;
@override final  AppAppearance appearance;
@override final  TelemetrySettings telemetry;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.appearance, appearance) || other.appearance == appearance)&&(identical(other.telemetry, telemetry) || other.telemetry == telemetry));
}


@override
int get hashCode => Object.hash(runtimeType,locale,appearance,telemetry);

@override
String toString() {
  return 'AppSettings(locale: $locale, appearance: $appearance, telemetry: $telemetry)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(defaultValue: null) AppLocale? locale, AppAppearance appearance, TelemetrySettings telemetry
});


@override $AppAppearanceCopyWith<$Res> get appearance;@override $TelemetrySettingsCopyWith<$Res> get telemetry;

}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = freezed,Object? appearance = null,Object? telemetry = null,}) {
  return _then(_AppSettings(
locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as AppLocale?,appearance: null == appearance ? _self.appearance : appearance // ignore: cast_nullable_to_non_nullable
as AppAppearance,telemetry: null == telemetry ? _self.telemetry : telemetry // ignore: cast_nullable_to_non_nullable
as TelemetrySettings,
  ));
}

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppAppearanceCopyWith<$Res> get appearance {
  
  return $AppAppearanceCopyWith<$Res>(_self.appearance, (value) {
    return _then(_self.copyWith(appearance: value));
  });
}/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TelemetrySettingsCopyWith<$Res> get telemetry {
  
  return $TelemetrySettingsCopyWith<$Res>(_self.telemetry, (value) {
    return _then(_self.copyWith(telemetry: value));
  });
}
}

/// @nodoc
mixin _$AppAppearance {

@JsonKey(defaultValue: AppThemeMode.system) AppThemeMode get themeMode;@JsonKey(defaultValue: true) bool get useSystemColors;@JsonKey(defaultValue: false) bool get useAccentColor;/// Stored as ARGB int
@JsonKey(defaultValue: 0xFFFF5252) int get accentColor;/// Whether to use animated graphics instead of static icons for decorative visuals.
@JsonKey(defaultValue: true) bool get useAnimatedGraphics;
/// Create a copy of AppAppearance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppAppearanceCopyWith<AppAppearance> get copyWith => _$AppAppearanceCopyWithImpl<AppAppearance>(this as AppAppearance, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppAppearance&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.useSystemColors, useSystemColors) || other.useSystemColors == useSystemColors)&&(identical(other.useAccentColor, useAccentColor) || other.useAccentColor == useAccentColor)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.useAnimatedGraphics, useAnimatedGraphics) || other.useAnimatedGraphics == useAnimatedGraphics));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,useSystemColors,useAccentColor,accentColor,useAnimatedGraphics);

@override
String toString() {
  return 'AppAppearance(themeMode: $themeMode, useSystemColors: $useSystemColors, useAccentColor: $useAccentColor, accentColor: $accentColor, useAnimatedGraphics: $useAnimatedGraphics)';
}


}

/// @nodoc
abstract mixin class $AppAppearanceCopyWith<$Res>  {
  factory $AppAppearanceCopyWith(AppAppearance value, $Res Function(AppAppearance) _then) = _$AppAppearanceCopyWithImpl;
@useResult
$Res call({
@JsonKey(defaultValue: AppThemeMode.system) AppThemeMode themeMode,@JsonKey(defaultValue: true) bool useSystemColors,@JsonKey(defaultValue: false) bool useAccentColor,@JsonKey(defaultValue: 0xFFFF5252) int accentColor,@JsonKey(defaultValue: true) bool useAnimatedGraphics
});




}
/// @nodoc
class _$AppAppearanceCopyWithImpl<$Res>
    implements $AppAppearanceCopyWith<$Res> {
  _$AppAppearanceCopyWithImpl(this._self, this._then);

  final AppAppearance _self;
  final $Res Function(AppAppearance) _then;

/// Create a copy of AppAppearance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? useSystemColors = null,Object? useAccentColor = null,Object? accentColor = null,Object? useAnimatedGraphics = null,}) {
  return _then(AppAppearance(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,useSystemColors: null == useSystemColors ? _self.useSystemColors : useSystemColors // ignore: cast_nullable_to_non_nullable
as bool,useAccentColor: null == useAccentColor ? _self.useAccentColor : useAccentColor // ignore: cast_nullable_to_non_nullable
as bool,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as int,useAnimatedGraphics: null == useAnimatedGraphics ? _self.useAnimatedGraphics : useAnimatedGraphics // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppAppearance].
extension AppAppearancePatterns on AppAppearance {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppAppearance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppAppearance() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppAppearance value)  $default,){
final _that = this;
switch (_that) {
case _AppAppearance():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppAppearance value)?  $default,){
final _that = this;
switch (_that) {
case _AppAppearance() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: AppThemeMode.system)  AppThemeMode themeMode, @JsonKey(defaultValue: true)  bool useSystemColors, @JsonKey(defaultValue: false)  bool useAccentColor, @JsonKey(defaultValue: 0xFFFF5252)  int accentColor, @JsonKey(defaultValue: true)  bool useAnimatedGraphics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppAppearance() when $default != null:
return $default(_that.themeMode,_that.useSystemColors,_that.useAccentColor,_that.accentColor,_that.useAnimatedGraphics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: AppThemeMode.system)  AppThemeMode themeMode, @JsonKey(defaultValue: true)  bool useSystemColors, @JsonKey(defaultValue: false)  bool useAccentColor, @JsonKey(defaultValue: 0xFFFF5252)  int accentColor, @JsonKey(defaultValue: true)  bool useAnimatedGraphics)  $default,) {final _that = this;
switch (_that) {
case _AppAppearance():
return $default(_that.themeMode,_that.useSystemColors,_that.useAccentColor,_that.accentColor,_that.useAnimatedGraphics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(defaultValue: AppThemeMode.system)  AppThemeMode themeMode, @JsonKey(defaultValue: true)  bool useSystemColors, @JsonKey(defaultValue: false)  bool useAccentColor, @JsonKey(defaultValue: 0xFFFF5252)  int accentColor, @JsonKey(defaultValue: true)  bool useAnimatedGraphics)?  $default,) {final _that = this;
switch (_that) {
case _AppAppearance() when $default != null:
return $default(_that.themeMode,_that.useSystemColors,_that.useAccentColor,_that.accentColor,_that.useAnimatedGraphics);case _:
  return null;

}
}

}

/// @nodoc


class _AppAppearance extends AppAppearance {
  const _AppAppearance({@JsonKey(defaultValue: AppThemeMode.system) required this.themeMode, @JsonKey(defaultValue: true) required this.useSystemColors, @JsonKey(defaultValue: false) required this.useAccentColor, @JsonKey(defaultValue: 0xFFFF5252) required this.accentColor, @JsonKey(defaultValue: true) required this.useAnimatedGraphics}): super(themeMode: themeMode, useSystemColors: useSystemColors, useAccentColor: useAccentColor, accentColor: accentColor, useAnimatedGraphics: useAnimatedGraphics);
  

@override@JsonKey(defaultValue: AppThemeMode.system) final  AppThemeMode themeMode;
@override@JsonKey(defaultValue: true) final  bool useSystemColors;
@override@JsonKey(defaultValue: false) final  bool useAccentColor;
/// Stored as ARGB int
@override@JsonKey(defaultValue: 0xFFFF5252) final  int accentColor;
/// Whether to use animated graphics instead of static icons for decorative visuals.
@override@JsonKey(defaultValue: true) final  bool useAnimatedGraphics;

/// Create a copy of AppAppearance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppAppearanceCopyWith<_AppAppearance> get copyWith => __$AppAppearanceCopyWithImpl<_AppAppearance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppAppearance&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.useSystemColors, useSystemColors) || other.useSystemColors == useSystemColors)&&(identical(other.useAccentColor, useAccentColor) || other.useAccentColor == useAccentColor)&&(identical(other.accentColor, accentColor) || other.accentColor == accentColor)&&(identical(other.useAnimatedGraphics, useAnimatedGraphics) || other.useAnimatedGraphics == useAnimatedGraphics));
}


@override
int get hashCode => Object.hash(runtimeType,themeMode,useSystemColors,useAccentColor,accentColor,useAnimatedGraphics);

@override
String toString() {
  return 'AppAppearance(themeMode: $themeMode, useSystemColors: $useSystemColors, useAccentColor: $useAccentColor, accentColor: $accentColor, useAnimatedGraphics: $useAnimatedGraphics)';
}


}

/// @nodoc
abstract mixin class _$AppAppearanceCopyWith<$Res> implements $AppAppearanceCopyWith<$Res> {
  factory _$AppAppearanceCopyWith(_AppAppearance value, $Res Function(_AppAppearance) _then) = __$AppAppearanceCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(defaultValue: AppThemeMode.system) AppThemeMode themeMode,@JsonKey(defaultValue: true) bool useSystemColors,@JsonKey(defaultValue: false) bool useAccentColor,@JsonKey(defaultValue: 0xFFFF5252) int accentColor,@JsonKey(defaultValue: true) bool useAnimatedGraphics
});




}
/// @nodoc
class __$AppAppearanceCopyWithImpl<$Res>
    implements _$AppAppearanceCopyWith<$Res> {
  __$AppAppearanceCopyWithImpl(this._self, this._then);

  final _AppAppearance _self;
  final $Res Function(_AppAppearance) _then;

/// Create a copy of AppAppearance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? useSystemColors = null,Object? useAccentColor = null,Object? accentColor = null,Object? useAnimatedGraphics = null,}) {
  return _then(_AppAppearance(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,useSystemColors: null == useSystemColors ? _self.useSystemColors : useSystemColors // ignore: cast_nullable_to_non_nullable
as bool,useAccentColor: null == useAccentColor ? _self.useAccentColor : useAccentColor // ignore: cast_nullable_to_non_nullable
as bool,accentColor: null == accentColor ? _self.accentColor : accentColor // ignore: cast_nullable_to_non_nullable
as int,useAnimatedGraphics: null == useAnimatedGraphics ? _self.useAnimatedGraphics : useAnimatedGraphics // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$TelemetrySettings {

@JsonKey(defaultValue: false) bool get sendCrashReports;
/// Create a copy of TelemetrySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TelemetrySettingsCopyWith<TelemetrySettings> get copyWith => _$TelemetrySettingsCopyWithImpl<TelemetrySettings>(this as TelemetrySettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TelemetrySettings&&(identical(other.sendCrashReports, sendCrashReports) || other.sendCrashReports == sendCrashReports));
}


@override
int get hashCode => Object.hash(runtimeType,sendCrashReports);

@override
String toString() {
  return 'TelemetrySettings(sendCrashReports: $sendCrashReports)';
}


}

/// @nodoc
abstract mixin class $TelemetrySettingsCopyWith<$Res>  {
  factory $TelemetrySettingsCopyWith(TelemetrySettings value, $Res Function(TelemetrySettings) _then) = _$TelemetrySettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(defaultValue: false) bool sendCrashReports
});




}
/// @nodoc
class _$TelemetrySettingsCopyWithImpl<$Res>
    implements $TelemetrySettingsCopyWith<$Res> {
  _$TelemetrySettingsCopyWithImpl(this._self, this._then);

  final TelemetrySettings _self;
  final $Res Function(TelemetrySettings) _then;

/// Create a copy of TelemetrySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sendCrashReports = null,}) {
  return _then(TelemetrySettings(
sendCrashReports: null == sendCrashReports ? _self.sendCrashReports : sendCrashReports // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TelemetrySettings].
extension TelemetrySettingsPatterns on TelemetrySettings {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TelemetrySettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TelemetrySettings() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TelemetrySettings value)  $default,){
final _that = this;
switch (_that) {
case _TelemetrySettings():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TelemetrySettings value)?  $default,){
final _that = this;
switch (_that) {
case _TelemetrySettings() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: false)  bool sendCrashReports)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TelemetrySettings() when $default != null:
return $default(_that.sendCrashReports);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(defaultValue: false)  bool sendCrashReports)  $default,) {final _that = this;
switch (_that) {
case _TelemetrySettings():
return $default(_that.sendCrashReports);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(defaultValue: false)  bool sendCrashReports)?  $default,) {final _that = this;
switch (_that) {
case _TelemetrySettings() when $default != null:
return $default(_that.sendCrashReports);case _:
  return null;

}
}

}

/// @nodoc


class _TelemetrySettings extends TelemetrySettings {
  const _TelemetrySettings({@JsonKey(defaultValue: false) required this.sendCrashReports}): super(sendCrashReports: sendCrashReports);
  

@override@JsonKey(defaultValue: false) final  bool sendCrashReports;

/// Create a copy of TelemetrySettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TelemetrySettingsCopyWith<_TelemetrySettings> get copyWith => __$TelemetrySettingsCopyWithImpl<_TelemetrySettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TelemetrySettings&&(identical(other.sendCrashReports, sendCrashReports) || other.sendCrashReports == sendCrashReports));
}


@override
int get hashCode => Object.hash(runtimeType,sendCrashReports);

@override
String toString() {
  return 'TelemetrySettings(sendCrashReports: $sendCrashReports)';
}


}

/// @nodoc
abstract mixin class _$TelemetrySettingsCopyWith<$Res> implements $TelemetrySettingsCopyWith<$Res> {
  factory _$TelemetrySettingsCopyWith(_TelemetrySettings value, $Res Function(_TelemetrySettings) _then) = __$TelemetrySettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(defaultValue: false) bool sendCrashReports
});




}
/// @nodoc
class __$TelemetrySettingsCopyWithImpl<$Res>
    implements _$TelemetrySettingsCopyWith<$Res> {
  __$TelemetrySettingsCopyWithImpl(this._self, this._then);

  final _TelemetrySettings _self;
  final $Res Function(_TelemetrySettings) _then;

/// Create a copy of TelemetrySettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sendCrashReports = null,}) {
  return _then(_TelemetrySettings(
sendCrashReports: null == sendCrashReports ? _self.sendCrashReports : sendCrashReports // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
