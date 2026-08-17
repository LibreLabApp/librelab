// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lab_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LabSettingsState {

 FetchSettingsState get fetchSettingsState; UpdateSettingsState get updateSettingsState;
/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LabSettingsStateCopyWith<LabSettingsState> get copyWith => _$LabSettingsStateCopyWithImpl<LabSettingsState>(this as LabSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LabSettingsState&&(identical(other.fetchSettingsState, fetchSettingsState) || other.fetchSettingsState == fetchSettingsState)&&(identical(other.updateSettingsState, updateSettingsState) || other.updateSettingsState == updateSettingsState));
}


@override
int get hashCode => Object.hash(runtimeType,fetchSettingsState,updateSettingsState);

@override
String toString() {
  return 'LabSettingsState(fetchSettingsState: $fetchSettingsState, updateSettingsState: $updateSettingsState)';
}


}

/// @nodoc
abstract mixin class $LabSettingsStateCopyWith<$Res>  {
  factory $LabSettingsStateCopyWith(LabSettingsState value, $Res Function(LabSettingsState) _then) = _$LabSettingsStateCopyWithImpl;
@useResult
$Res call({
 FetchSettingsState fetchSettingsState, UpdateSettingsState updateSettingsState
});


$FetchSettingsStateCopyWith<$Res> get fetchSettingsState;$UpdateSettingsStateCopyWith<$Res> get updateSettingsState;

}
/// @nodoc
class _$LabSettingsStateCopyWithImpl<$Res>
    implements $LabSettingsStateCopyWith<$Res> {
  _$LabSettingsStateCopyWithImpl(this._self, this._then);

  final LabSettingsState _self;
  final $Res Function(LabSettingsState) _then;

/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fetchSettingsState = null,Object? updateSettingsState = null,}) {
  return _then(LabSettingsState(
fetchSettingsState: null == fetchSettingsState ? _self.fetchSettingsState : fetchSettingsState // ignore: cast_nullable_to_non_nullable
as FetchSettingsState,updateSettingsState: null == updateSettingsState ? _self.updateSettingsState : updateSettingsState // ignore: cast_nullable_to_non_nullable
as UpdateSettingsState,
  ));
}
/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FetchSettingsStateCopyWith<$Res> get fetchSettingsState {
  
  return $FetchSettingsStateCopyWith<$Res>(_self.fetchSettingsState, (value) {
    return _then(_self.copyWith(fetchSettingsState: value));
  });
}/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateSettingsStateCopyWith<$Res> get updateSettingsState {
  
  return $UpdateSettingsStateCopyWith<$Res>(_self.updateSettingsState, (value) {
    return _then(_self.copyWith(updateSettingsState: value));
  });
}
}


/// Adds pattern-matching-related methods to [LabSettingsState].
extension LabSettingsStatePatterns on LabSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LabSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LabSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LabSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _LabSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LabSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _LabSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FetchSettingsState fetchSettingsState,  UpdateSettingsState updateSettingsState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LabSettingsState() when $default != null:
return $default(_that.fetchSettingsState,_that.updateSettingsState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FetchSettingsState fetchSettingsState,  UpdateSettingsState updateSettingsState)  $default,) {final _that = this;
switch (_that) {
case _LabSettingsState():
return $default(_that.fetchSettingsState,_that.updateSettingsState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FetchSettingsState fetchSettingsState,  UpdateSettingsState updateSettingsState)?  $default,) {final _that = this;
switch (_that) {
case _LabSettingsState() when $default != null:
return $default(_that.fetchSettingsState,_that.updateSettingsState);case _:
  return null;

}
}

}

/// @nodoc


class _LabSettingsState extends LabSettingsState {
  const _LabSettingsState({required this.fetchSettingsState, required this.updateSettingsState}): super(fetchSettingsState: fetchSettingsState, updateSettingsState: updateSettingsState);
  

@override final  FetchSettingsState fetchSettingsState;
@override final  UpdateSettingsState updateSettingsState;

/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LabSettingsStateCopyWith<_LabSettingsState> get copyWith => __$LabSettingsStateCopyWithImpl<_LabSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LabSettingsState&&(identical(other.fetchSettingsState, fetchSettingsState) || other.fetchSettingsState == fetchSettingsState)&&(identical(other.updateSettingsState, updateSettingsState) || other.updateSettingsState == updateSettingsState));
}


@override
int get hashCode => Object.hash(runtimeType,fetchSettingsState,updateSettingsState);

@override
String toString() {
  return 'LabSettingsState(fetchSettingsState: $fetchSettingsState, updateSettingsState: $updateSettingsState)';
}


}

/// @nodoc
abstract mixin class _$LabSettingsStateCopyWith<$Res> implements $LabSettingsStateCopyWith<$Res> {
  factory _$LabSettingsStateCopyWith(_LabSettingsState value, $Res Function(_LabSettingsState) _then) = __$LabSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 FetchSettingsState fetchSettingsState, UpdateSettingsState updateSettingsState
});


@override $FetchSettingsStateCopyWith<$Res> get fetchSettingsState;@override $UpdateSettingsStateCopyWith<$Res> get updateSettingsState;

}
/// @nodoc
class __$LabSettingsStateCopyWithImpl<$Res>
    implements _$LabSettingsStateCopyWith<$Res> {
  __$LabSettingsStateCopyWithImpl(this._self, this._then);

  final _LabSettingsState _self;
  final $Res Function(_LabSettingsState) _then;

/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fetchSettingsState = null,Object? updateSettingsState = null,}) {
  return _then(_LabSettingsState(
fetchSettingsState: null == fetchSettingsState ? _self.fetchSettingsState : fetchSettingsState // ignore: cast_nullable_to_non_nullable
as FetchSettingsState,updateSettingsState: null == updateSettingsState ? _self.updateSettingsState : updateSettingsState // ignore: cast_nullable_to_non_nullable
as UpdateSettingsState,
  ));
}

/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FetchSettingsStateCopyWith<$Res> get fetchSettingsState {
  
  return $FetchSettingsStateCopyWith<$Res>(_self.fetchSettingsState, (value) {
    return _then(_self.copyWith(fetchSettingsState: value));
  });
}/// Create a copy of LabSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UpdateSettingsStateCopyWith<$Res> get updateSettingsState {
  
  return $UpdateSettingsStateCopyWith<$Res>(_self.updateSettingsState, (value) {
    return _then(_self.copyWith(updateSettingsState: value));
  });
}
}

/// @nodoc
mixin _$FetchSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FetchSettingsState()';
}


}

/// @nodoc
class $FetchSettingsStateCopyWith<$Res>  {
$FetchSettingsStateCopyWith(FetchSettingsState _, $Res Function(FetchSettingsState) __);
}


/// Adds pattern-matching-related methods to [FetchSettingsState].
extension FetchSettingsStatePatterns on FetchSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FetchSettingsInitial value)?  initial,TResult Function( FetchSettingsLoading value)?  loading,TResult Function( FetchSettingsSuccess value)?  success,TResult Function( FetchSettingsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FetchSettingsInitial() when initial != null:
return initial(_that);case FetchSettingsLoading() when loading != null:
return loading(_that);case FetchSettingsSuccess() when success != null:
return success(_that);case FetchSettingsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FetchSettingsInitial value)  initial,required TResult Function( FetchSettingsLoading value)  loading,required TResult Function( FetchSettingsSuccess value)  success,required TResult Function( FetchSettingsFailure value)  failure,}){
final _that = this;
switch (_that) {
case FetchSettingsInitial():
return initial(_that);case FetchSettingsLoading():
return loading(_that);case FetchSettingsSuccess():
return success(_that);case FetchSettingsFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FetchSettingsInitial value)?  initial,TResult? Function( FetchSettingsLoading value)?  loading,TResult? Function( FetchSettingsSuccess value)?  success,TResult? Function( FetchSettingsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case FetchSettingsInitial() when initial != null:
return initial(_that);case FetchSettingsLoading() when loading != null:
return loading(_that);case FetchSettingsSuccess() when success != null:
return success(_that);case FetchSettingsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LabSettings settings)?  success,TResult Function( ApiRequestFailure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FetchSettingsInitial() when initial != null:
return initial();case FetchSettingsLoading() when loading != null:
return loading();case FetchSettingsSuccess() when success != null:
return success(_that.settings);case FetchSettingsFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LabSettings settings)  success,required TResult Function( ApiRequestFailure failure)  failure,}) {final _that = this;
switch (_that) {
case FetchSettingsInitial():
return initial();case FetchSettingsLoading():
return loading();case FetchSettingsSuccess():
return success(_that.settings);case FetchSettingsFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LabSettings settings)?  success,TResult? Function( ApiRequestFailure failure)?  failure,}) {final _that = this;
switch (_that) {
case FetchSettingsInitial() when initial != null:
return initial();case FetchSettingsLoading() when loading != null:
return loading();case FetchSettingsSuccess() when success != null:
return success(_that.settings);case FetchSettingsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class FetchSettingsInitial implements FetchSettingsState {
  const FetchSettingsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSettingsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FetchSettingsState.initial()';
}


}




/// @nodoc


class FetchSettingsLoading implements FetchSettingsState {
  const FetchSettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FetchSettingsState.loading()';
}


}




/// @nodoc


class FetchSettingsSuccess implements FetchSettingsState {
  const FetchSettingsSuccess(this.settings);
  

 final  LabSettings settings;

/// Create a copy of FetchSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchSettingsSuccessCopyWith<FetchSettingsSuccess> get copyWith => _$FetchSettingsSuccessCopyWithImpl<FetchSettingsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSettingsSuccess&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'FetchSettingsState.success(settings: $settings)';
}


}

/// @nodoc
abstract mixin class $FetchSettingsSuccessCopyWith<$Res> implements $FetchSettingsStateCopyWith<$Res> {
  factory $FetchSettingsSuccessCopyWith(FetchSettingsSuccess value, $Res Function(FetchSettingsSuccess) _then) = _$FetchSettingsSuccessCopyWithImpl;
@useResult
$Res call({
 LabSettings settings
});




}
/// @nodoc
class _$FetchSettingsSuccessCopyWithImpl<$Res>
    implements $FetchSettingsSuccessCopyWith<$Res> {
  _$FetchSettingsSuccessCopyWithImpl(this._self, this._then);

  final FetchSettingsSuccess _self;
  final $Res Function(FetchSettingsSuccess) _then;

/// Create a copy of FetchSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(FetchSettingsSuccess(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LabSettings,
  ));
}


}

/// @nodoc


class FetchSettingsFailure implements FetchSettingsState {
  const FetchSettingsFailure(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of FetchSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FetchSettingsFailureCopyWith<FetchSettingsFailure> get copyWith => _$FetchSettingsFailureCopyWithImpl<FetchSettingsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FetchSettingsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'FetchSettingsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $FetchSettingsFailureCopyWith<$Res> implements $FetchSettingsStateCopyWith<$Res> {
  factory $FetchSettingsFailureCopyWith(FetchSettingsFailure value, $Res Function(FetchSettingsFailure) _then) = _$FetchSettingsFailureCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$FetchSettingsFailureCopyWithImpl<$Res>
    implements $FetchSettingsFailureCopyWith<$Res> {
  _$FetchSettingsFailureCopyWithImpl(this._self, this._then);

  final FetchSettingsFailure _self;
  final $Res Function(FetchSettingsFailure) _then;

/// Create a copy of FetchSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(FetchSettingsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

/// @nodoc
mixin _$UpdateSettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateSettingsState()';
}


}

/// @nodoc
class $UpdateSettingsStateCopyWith<$Res>  {
$UpdateSettingsStateCopyWith(UpdateSettingsState _, $Res Function(UpdateSettingsState) __);
}


/// Adds pattern-matching-related methods to [UpdateSettingsState].
extension UpdateSettingsStatePatterns on UpdateSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UpdateSettingsInitial value)?  initial,TResult Function( UpdateSettingsLoading value)?  loading,TResult Function( UpdateSettingsSuccess value)?  success,TResult Function( UpdateSettingsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UpdateSettingsInitial() when initial != null:
return initial(_that);case UpdateSettingsLoading() when loading != null:
return loading(_that);case UpdateSettingsSuccess() when success != null:
return success(_that);case UpdateSettingsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UpdateSettingsInitial value)  initial,required TResult Function( UpdateSettingsLoading value)  loading,required TResult Function( UpdateSettingsSuccess value)  success,required TResult Function( UpdateSettingsFailure value)  failure,}){
final _that = this;
switch (_that) {
case UpdateSettingsInitial():
return initial(_that);case UpdateSettingsLoading():
return loading(_that);case UpdateSettingsSuccess():
return success(_that);case UpdateSettingsFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UpdateSettingsInitial value)?  initial,TResult? Function( UpdateSettingsLoading value)?  loading,TResult? Function( UpdateSettingsSuccess value)?  success,TResult? Function( UpdateSettingsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case UpdateSettingsInitial() when initial != null:
return initial(_that);case UpdateSettingsLoading() when loading != null:
return loading(_that);case UpdateSettingsSuccess() when success != null:
return success(_that);case UpdateSettingsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( ApiRequestFailure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UpdateSettingsInitial() when initial != null:
return initial();case UpdateSettingsLoading() when loading != null:
return loading();case UpdateSettingsSuccess() when success != null:
return success();case UpdateSettingsFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( ApiRequestFailure failure)  failure,}) {final _that = this;
switch (_that) {
case UpdateSettingsInitial():
return initial();case UpdateSettingsLoading():
return loading();case UpdateSettingsSuccess():
return success();case UpdateSettingsFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( ApiRequestFailure failure)?  failure,}) {final _that = this;
switch (_that) {
case UpdateSettingsInitial() when initial != null:
return initial();case UpdateSettingsLoading() when loading != null:
return loading();case UpdateSettingsSuccess() when success != null:
return success();case UpdateSettingsFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class UpdateSettingsInitial implements UpdateSettingsState {
  const UpdateSettingsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettingsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateSettingsState.initial()';
}


}




/// @nodoc


class UpdateSettingsLoading implements UpdateSettingsState {
  const UpdateSettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateSettingsState.loading()';
}


}




/// @nodoc


class UpdateSettingsSuccess implements UpdateSettingsState {
  const UpdateSettingsSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettingsSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UpdateSettingsState.success()';
}


}




/// @nodoc


class UpdateSettingsFailure implements UpdateSettingsState {
  const UpdateSettingsFailure(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of UpdateSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateSettingsFailureCopyWith<UpdateSettingsFailure> get copyWith => _$UpdateSettingsFailureCopyWithImpl<UpdateSettingsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateSettingsFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'UpdateSettingsState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $UpdateSettingsFailureCopyWith<$Res> implements $UpdateSettingsStateCopyWith<$Res> {
  factory $UpdateSettingsFailureCopyWith(UpdateSettingsFailure value, $Res Function(UpdateSettingsFailure) _then) = _$UpdateSettingsFailureCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$UpdateSettingsFailureCopyWithImpl<$Res>
    implements $UpdateSettingsFailureCopyWith<$Res> {
  _$UpdateSettingsFailureCopyWithImpl(this._self, this._then);

  final UpdateSettingsFailure _self;
  final $Res Function(UpdateSettingsFailure) _then;

/// Create a copy of UpdateSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(UpdateSettingsFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

// dart format on
