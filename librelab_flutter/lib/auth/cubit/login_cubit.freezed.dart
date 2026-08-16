// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState()';
}


}

/// @nodoc
class $LoginStateCopyWith<$Res>  {
$LoginStateCopyWith(LoginState _, $Res Function(LoginState) __);
}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Load value)?  load,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,TResult Function( RequestFailure value)?  requestFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Load() when load != null:
return load(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case RequestFailure() when requestFailure != null:
return requestFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Load value)  load,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,required TResult Function( RequestFailure value)  requestFailure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Load():
return load(_that);case Success():
return success(_that);case Failure():
return failure(_that);case RequestFailure():
return requestFailure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Load value)?  load,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,TResult? Function( RequestFailure value)?  requestFailure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Load() when load != null:
return load(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
return failure(_that);case RequestFailure() when requestFailure != null:
return requestFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  load,TResult Function( LoginResultSuccess result,  bool persistAuthSession)?  success,TResult Function( LoginFailure failure)?  failure,TResult Function( ApiRequestFailure failure)?  requestFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Load() when load != null:
return load();case Success() when success != null:
return success(_that.result,_that.persistAuthSession);case Failure() when failure != null:
return failure(_that.failure);case RequestFailure() when requestFailure != null:
return requestFailure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  load,required TResult Function( LoginResultSuccess result,  bool persistAuthSession)  success,required TResult Function( LoginFailure failure)  failure,required TResult Function( ApiRequestFailure failure)  requestFailure,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Load():
return load();case Success():
return success(_that.result,_that.persistAuthSession);case Failure():
return failure(_that.failure);case RequestFailure():
return requestFailure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  load,TResult? Function( LoginResultSuccess result,  bool persistAuthSession)?  success,TResult? Function( LoginFailure failure)?  failure,TResult? Function( ApiRequestFailure failure)?  requestFailure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Load() when load != null:
return load();case Success() when success != null:
return success(_that.result,_that.persistAuthSession);case Failure() when failure != null:
return failure(_that.failure);case RequestFailure() when requestFailure != null:
return requestFailure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements LoginState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.initial()';
}


}




/// @nodoc


class Load implements LoginState {
  const Load();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginState.load()';
}


}




/// @nodoc


class Success implements LoginState {
  const Success(this.result, {required this.persistAuthSession});
  

 final  LoginResultSuccess result;
 final  bool persistAuthSession;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.result, result) || other.result == result)&&(identical(other.persistAuthSession, persistAuthSession) || other.persistAuthSession == persistAuthSession));
}


@override
int get hashCode => Object.hash(runtimeType,result,persistAuthSession);

@override
String toString() {
  return 'LoginState.success(result: $result, persistAuthSession: $persistAuthSession)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 LoginResultSuccess result, bool persistAuthSession
});




}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,Object? persistAuthSession = null,}) {
  return _then(Success(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as LoginResultSuccess,persistAuthSession: null == persistAuthSession ? _self.persistAuthSession : persistAuthSession // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class Failure implements LoginState {
  const Failure(this.failure);
  

 final  LoginFailure failure;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'LoginState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 LoginFailure failure
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as LoginFailure,
  ));
}


}

/// @nodoc


class RequestFailure implements LoginState {
  const RequestFailure(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestFailureCopyWith<RequestFailure> get copyWith => _$RequestFailureCopyWithImpl<RequestFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'LoginState.requestFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RequestFailureCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory $RequestFailureCopyWith(RequestFailure value, $Res Function(RequestFailure) _then) = _$RequestFailureCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$RequestFailureCopyWithImpl<$Res>
    implements $RequestFailureCopyWith<$Res> {
  _$RequestFailureCopyWithImpl(this._self, this._then);

  final RequestFailure _self;
  final $Res Function(RequestFailure) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(RequestFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

// dart format on
