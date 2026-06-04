// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppConfig {

 ApiServerConfig get apiServer; MdnsServicePublishConfig get mdnsServicePublish; DatabaseConfig get database; SetupPromptDeclinedConfig get setupPromptDeclined;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.apiServer, apiServer) || other.apiServer == apiServer)&&(identical(other.mdnsServicePublish, mdnsServicePublish) || other.mdnsServicePublish == mdnsServicePublish)&&(identical(other.database, database) || other.database == database)&&(identical(other.setupPromptDeclined, setupPromptDeclined) || other.setupPromptDeclined == setupPromptDeclined));
}


@override
int get hashCode => Object.hash(runtimeType,apiServer,mdnsServicePublish,database,setupPromptDeclined);

@override
String toString() {
  return 'AppConfig(apiServer: $apiServer, mdnsServicePublish: $mdnsServicePublish, database: $database, setupPromptDeclined: $setupPromptDeclined)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 ApiServerConfig apiServer, MdnsServicePublishConfig mdnsServicePublish, DatabaseConfig database, SetupPromptDeclinedConfig setupPromptDeclined
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiServer = null,Object? mdnsServicePublish = null,Object? database = null,Object? setupPromptDeclined = null,}) {
  return _then(AppConfig(
apiServer: null == apiServer ? _self.apiServer : apiServer // ignore: cast_nullable_to_non_nullable
as ApiServerConfig,mdnsServicePublish: null == mdnsServicePublish ? _self.mdnsServicePublish : mdnsServicePublish // ignore: cast_nullable_to_non_nullable
as MdnsServicePublishConfig,database: null == database ? _self.database : database // ignore: cast_nullable_to_non_nullable
as DatabaseConfig,setupPromptDeclined: null == setupPromptDeclined ? _self.setupPromptDeclined : setupPromptDeclined // ignore: cast_nullable_to_non_nullable
as SetupPromptDeclinedConfig,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

/// @nodoc
mixin _$SetupPromptDeclinedConfig {

 bool get postgres; bool get systemMdnsService;
/// Create a copy of SetupPromptDeclinedConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupPromptDeclinedConfigCopyWith<SetupPromptDeclinedConfig> get copyWith => _$SetupPromptDeclinedConfigCopyWithImpl<SetupPromptDeclinedConfig>(this as SetupPromptDeclinedConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupPromptDeclinedConfig&&(identical(other.postgres, postgres) || other.postgres == postgres)&&(identical(other.systemMdnsService, systemMdnsService) || other.systemMdnsService == systemMdnsService));
}


@override
int get hashCode => Object.hash(runtimeType,postgres,systemMdnsService);

@override
String toString() {
  return 'SetupPromptDeclinedConfig(postgres: $postgres, systemMdnsService: $systemMdnsService)';
}


}

/// @nodoc
abstract mixin class $SetupPromptDeclinedConfigCopyWith<$Res>  {
  factory $SetupPromptDeclinedConfigCopyWith(SetupPromptDeclinedConfig value, $Res Function(SetupPromptDeclinedConfig) _then) = _$SetupPromptDeclinedConfigCopyWithImpl;
@useResult
$Res call({
 bool postgres, bool systemMdnsService
});




}
/// @nodoc
class _$SetupPromptDeclinedConfigCopyWithImpl<$Res>
    implements $SetupPromptDeclinedConfigCopyWith<$Res> {
  _$SetupPromptDeclinedConfigCopyWithImpl(this._self, this._then);

  final SetupPromptDeclinedConfig _self;
  final $Res Function(SetupPromptDeclinedConfig) _then;

/// Create a copy of SetupPromptDeclinedConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? postgres = null,Object? systemMdnsService = null,}) {
  return _then(SetupPromptDeclinedConfig(
postgres: null == postgres ? _self.postgres : postgres // ignore: cast_nullable_to_non_nullable
as bool,systemMdnsService: null == systemMdnsService ? _self.systemMdnsService : systemMdnsService // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SetupPromptDeclinedConfig].
extension SetupPromptDeclinedConfigPatterns on SetupPromptDeclinedConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
