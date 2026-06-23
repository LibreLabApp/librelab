// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_selection_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServerSelectionState {

 ServerSelectionMethod get selectionMethod;/// The server base URL provided by the user to connect to the server.
///
/// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
///
/// if [selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery],
/// use [LocalDiscoveryState].
///
 String? get manualServerUrl;
/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerSelectionStateCopyWith<ServerSelectionState> get copyWith => _$ServerSelectionStateCopyWithImpl<ServerSelectionState>(this as ServerSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSelectionState&&(identical(other.selectionMethod, selectionMethod) || other.selectionMethod == selectionMethod)&&(identical(other.manualServerUrl, manualServerUrl) || other.manualServerUrl == manualServerUrl));
}


@override
int get hashCode => Object.hash(runtimeType,selectionMethod,manualServerUrl);

@override
String toString() {
  return 'ServerSelectionState(selectionMethod: $selectionMethod, manualServerUrl: $manualServerUrl)';
}


}

/// @nodoc
abstract mixin class $ServerSelectionStateCopyWith<$Res>  {
  factory $ServerSelectionStateCopyWith(ServerSelectionState value, $Res Function(ServerSelectionState) _then) = _$ServerSelectionStateCopyWithImpl;
@useResult
$Res call({
 ServerSelectionMethod selectionMethod, String? manualServerUrl
});




}
/// @nodoc
class _$ServerSelectionStateCopyWithImpl<$Res>
    implements $ServerSelectionStateCopyWith<$Res> {
  _$ServerSelectionStateCopyWithImpl(this._self, this._then);

  final ServerSelectionState _self;
  final $Res Function(ServerSelectionState) _then;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectionMethod = null,Object? manualServerUrl = freezed,}) {
  return _then(ServerSelectionState(
selectionMethod: null == selectionMethod ? _self.selectionMethod : selectionMethod // ignore: cast_nullable_to_non_nullable
as ServerSelectionMethod,manualServerUrl: freezed == manualServerUrl ? _self.manualServerUrl : manualServerUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServerSelectionState].
extension ServerSelectionStatePatterns on ServerSelectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerSelectionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerSelectionState value)  $default,){
final _that = this;
switch (_that) {
case _ServerSelectionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerSelectionState value)?  $default,){
final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServerSelectionMethod selectionMethod,  String? manualServerUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
return $default(_that.selectionMethod,_that.manualServerUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServerSelectionMethod selectionMethod,  String? manualServerUrl)  $default,) {final _that = this;
switch (_that) {
case _ServerSelectionState():
return $default(_that.selectionMethod,_that.manualServerUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServerSelectionMethod selectionMethod,  String? manualServerUrl)?  $default,) {final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
return $default(_that.selectionMethod,_that.manualServerUrl);case _:
  return null;

}
}

}

/// @nodoc


class _ServerSelectionState extends ServerSelectionState {
  const _ServerSelectionState({required this.selectionMethod, required this.manualServerUrl}): super(selectionMethod: selectionMethod, manualServerUrl: manualServerUrl);
  

@override final  ServerSelectionMethod selectionMethod;
/// The server base URL provided by the user to connect to the server.
///
/// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
///
/// if [selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery],
/// use [LocalDiscoveryState].
///
@override final  String? manualServerUrl;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerSelectionStateCopyWith<_ServerSelectionState> get copyWith => __$ServerSelectionStateCopyWithImpl<_ServerSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerSelectionState&&(identical(other.selectionMethod, selectionMethod) || other.selectionMethod == selectionMethod)&&(identical(other.manualServerUrl, manualServerUrl) || other.manualServerUrl == manualServerUrl));
}


@override
int get hashCode => Object.hash(runtimeType,selectionMethod,manualServerUrl);

@override
String toString() {
  return 'ServerSelectionState(selectionMethod: $selectionMethod, manualServerUrl: $manualServerUrl)';
}


}

/// @nodoc
abstract mixin class _$ServerSelectionStateCopyWith<$Res> implements $ServerSelectionStateCopyWith<$Res> {
  factory _$ServerSelectionStateCopyWith(_ServerSelectionState value, $Res Function(_ServerSelectionState) _then) = __$ServerSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 ServerSelectionMethod selectionMethod, String? manualServerUrl
});




}
/// @nodoc
class __$ServerSelectionStateCopyWithImpl<$Res>
    implements _$ServerSelectionStateCopyWith<$Res> {
  __$ServerSelectionStateCopyWithImpl(this._self, this._then);

  final _ServerSelectionState _self;
  final $Res Function(_ServerSelectionState) _then;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectionMethod = null,Object? manualServerUrl = freezed,}) {
  return _then(_ServerSelectionState(
selectionMethod: null == selectionMethod ? _self.selectionMethod : selectionMethod // ignore: cast_nullable_to_non_nullable
as ServerSelectionMethod,manualServerUrl: freezed == manualServerUrl ? _self.manualServerUrl : manualServerUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
