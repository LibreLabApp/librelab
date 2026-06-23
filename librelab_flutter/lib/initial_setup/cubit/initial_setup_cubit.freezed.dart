// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'initial_setup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InitialSetupState {

 InitialSetupStep get currentStep;
/// Create a copy of InitialSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InitialSetupStateCopyWith<InitialSetupState> get copyWith => _$InitialSetupStateCopyWithImpl<InitialSetupState>(this as InitialSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InitialSetupState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep);

@override
String toString() {
  return 'InitialSetupState(currentStep: $currentStep)';
}


}

/// @nodoc
abstract mixin class $InitialSetupStateCopyWith<$Res>  {
  factory $InitialSetupStateCopyWith(InitialSetupState value, $Res Function(InitialSetupState) _then) = _$InitialSetupStateCopyWithImpl;
@useResult
$Res call({
 InitialSetupStep currentStep
});




}
/// @nodoc
class _$InitialSetupStateCopyWithImpl<$Res>
    implements $InitialSetupStateCopyWith<$Res> {
  _$InitialSetupStateCopyWithImpl(this._self, this._then);

  final InitialSetupState _self;
  final $Res Function(InitialSetupState) _then;

/// Create a copy of InitialSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,}) {
  return _then(InitialSetupState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as InitialSetupStep,
  ));
}

}


/// Adds pattern-matching-related methods to [InitialSetupState].
extension InitialSetupStatePatterns on InitialSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InitialSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InitialSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InitialSetupState value)  $default,){
final _that = this;
switch (_that) {
case _InitialSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InitialSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _InitialSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InitialSetupStep currentStep)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InitialSetupState() when $default != null:
return $default(_that.currentStep);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InitialSetupStep currentStep)  $default,) {final _that = this;
switch (_that) {
case _InitialSetupState():
return $default(_that.currentStep);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InitialSetupStep currentStep)?  $default,) {final _that = this;
switch (_that) {
case _InitialSetupState() when $default != null:
return $default(_that.currentStep);case _:
  return null;

}
}

}

/// @nodoc


class _InitialSetupState extends InitialSetupState {
  const _InitialSetupState({required this.currentStep}): super(currentStep: currentStep);
  

@override final  InitialSetupStep currentStep;

/// Create a copy of InitialSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InitialSetupStateCopyWith<_InitialSetupState> get copyWith => __$InitialSetupStateCopyWithImpl<_InitialSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InitialSetupState&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep));
}


@override
int get hashCode => Object.hash(runtimeType,currentStep);

@override
String toString() {
  return 'InitialSetupState(currentStep: $currentStep)';
}


}

/// @nodoc
abstract mixin class _$InitialSetupStateCopyWith<$Res> implements $InitialSetupStateCopyWith<$Res> {
  factory _$InitialSetupStateCopyWith(_InitialSetupState value, $Res Function(_InitialSetupState) _then) = __$InitialSetupStateCopyWithImpl;
@override @useResult
$Res call({
 InitialSetupStep currentStep
});




}
/// @nodoc
class __$InitialSetupStateCopyWithImpl<$Res>
    implements _$InitialSetupStateCopyWith<$Res> {
  __$InitialSetupStateCopyWithImpl(this._self, this._then);

  final _InitialSetupState _self;
  final $Res Function(_InitialSetupState) _then;

/// Create a copy of InitialSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,}) {
  return _then(_InitialSetupState(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as InitialSetupStep,
  ));
}


}

// dart format on
