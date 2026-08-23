// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_identity_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginIdentityState {

 LoadLoginIdentitiesState get loadState; LogoutState get logoutState;
/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginIdentityStateCopyWith<LoginIdentityState> get copyWith => _$LoginIdentityStateCopyWithImpl<LoginIdentityState>(this as LoginIdentityState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginIdentityState&&(identical(other.loadState, loadState) || other.loadState == loadState)&&(identical(other.logoutState, logoutState) || other.logoutState == logoutState));
}


@override
int get hashCode => Object.hash(runtimeType,loadState,logoutState);

@override
String toString() {
  return 'LoginIdentityState(loadState: $loadState, logoutState: $logoutState)';
}


}

/// @nodoc
abstract mixin class $LoginIdentityStateCopyWith<$Res>  {
  factory $LoginIdentityStateCopyWith(LoginIdentityState value, $Res Function(LoginIdentityState) _then) = _$LoginIdentityStateCopyWithImpl;
@useResult
$Res call({
 LoadLoginIdentitiesState loadState, LogoutState logoutState
});


$LoadLoginIdentitiesStateCopyWith<$Res> get loadState;$LogoutStateCopyWith<$Res> get logoutState;

}
/// @nodoc
class _$LoginIdentityStateCopyWithImpl<$Res>
    implements $LoginIdentityStateCopyWith<$Res> {
  _$LoginIdentityStateCopyWithImpl(this._self, this._then);

  final LoginIdentityState _self;
  final $Res Function(LoginIdentityState) _then;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadState = null,Object? logoutState = null,}) {
  return _then(LoginIdentityState(
loadState: null == loadState ? _self.loadState : loadState // ignore: cast_nullable_to_non_nullable
as LoadLoginIdentitiesState,logoutState: null == logoutState ? _self.logoutState : logoutState // ignore: cast_nullable_to_non_nullable
as LogoutState,
  ));
}
/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadLoginIdentitiesStateCopyWith<$Res> get loadState {
  
  return $LoadLoginIdentitiesStateCopyWith<$Res>(_self.loadState, (value) {
    return _then(_self.copyWith(loadState: value));
  });
}/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LogoutStateCopyWith<$Res> get logoutState {
  
  return $LogoutStateCopyWith<$Res>(_self.logoutState, (value) {
    return _then(_self.copyWith(logoutState: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginIdentityState].
extension LoginIdentityStatePatterns on LoginIdentityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginIdentityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginIdentityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginIdentityState value)  $default,){
final _that = this;
switch (_that) {
case _LoginIdentityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginIdentityState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginIdentityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LoadLoginIdentitiesState loadState,  LogoutState logoutState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginIdentityState() when $default != null:
return $default(_that.loadState,_that.logoutState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LoadLoginIdentitiesState loadState,  LogoutState logoutState)  $default,) {final _that = this;
switch (_that) {
case _LoginIdentityState():
return $default(_that.loadState,_that.logoutState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LoadLoginIdentitiesState loadState,  LogoutState logoutState)?  $default,) {final _that = this;
switch (_that) {
case _LoginIdentityState() when $default != null:
return $default(_that.loadState,_that.logoutState);case _:
  return null;

}
}

}

/// @nodoc


class _LoginIdentityState extends LoginIdentityState {
  const _LoginIdentityState({required this.loadState, required this.logoutState}): super(loadState: loadState, logoutState: logoutState);
  

@override final  LoadLoginIdentitiesState loadState;
@override final  LogoutState logoutState;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginIdentityStateCopyWith<_LoginIdentityState> get copyWith => __$LoginIdentityStateCopyWithImpl<_LoginIdentityState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginIdentityState&&(identical(other.loadState, loadState) || other.loadState == loadState)&&(identical(other.logoutState, logoutState) || other.logoutState == logoutState));
}


@override
int get hashCode => Object.hash(runtimeType,loadState,logoutState);

@override
String toString() {
  return 'LoginIdentityState(loadState: $loadState, logoutState: $logoutState)';
}


}

/// @nodoc
abstract mixin class _$LoginIdentityStateCopyWith<$Res> implements $LoginIdentityStateCopyWith<$Res> {
  factory _$LoginIdentityStateCopyWith(_LoginIdentityState value, $Res Function(_LoginIdentityState) _then) = __$LoginIdentityStateCopyWithImpl;
@override @useResult
$Res call({
 LoadLoginIdentitiesState loadState, LogoutState logoutState
});


@override $LoadLoginIdentitiesStateCopyWith<$Res> get loadState;@override $LogoutStateCopyWith<$Res> get logoutState;

}
/// @nodoc
class __$LoginIdentityStateCopyWithImpl<$Res>
    implements _$LoginIdentityStateCopyWith<$Res> {
  __$LoginIdentityStateCopyWithImpl(this._self, this._then);

  final _LoginIdentityState _self;
  final $Res Function(_LoginIdentityState) _then;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadState = null,Object? logoutState = null,}) {
  return _then(_LoginIdentityState(
loadState: null == loadState ? _self.loadState : loadState // ignore: cast_nullable_to_non_nullable
as LoadLoginIdentitiesState,logoutState: null == logoutState ? _self.logoutState : logoutState // ignore: cast_nullable_to_non_nullable
as LogoutState,
  ));
}

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoadLoginIdentitiesStateCopyWith<$Res> get loadState {
  
  return $LoadLoginIdentitiesStateCopyWith<$Res>(_self.loadState, (value) {
    return _then(_self.copyWith(loadState: value));
  });
}/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LogoutStateCopyWith<$Res> get logoutState {
  
  return $LogoutStateCopyWith<$Res>(_self.logoutState, (value) {
    return _then(_self.copyWith(logoutState: value));
  });
}
}

/// @nodoc
mixin _$LoadLoginIdentitiesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLoginIdentitiesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoadLoginIdentitiesState()';
}


}

/// @nodoc
class $LoadLoginIdentitiesStateCopyWith<$Res>  {
$LoadLoginIdentitiesStateCopyWith(LoadLoginIdentitiesState _, $Res Function(LoadLoginIdentitiesState) __);
}


/// Adds pattern-matching-related methods to [LoadLoginIdentitiesState].
extension LoadLoginIdentitiesStatePatterns on LoadLoginIdentitiesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadLoginIdentitiesInitial value)?  initial,TResult Function( LoadLoginIdentitiesLoading value)?  loading,TResult Function( LoadLoginIdentitiesSuccess value)?  success,TResult Function( LoadLoginIdentitiesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial() when initial != null:
return initial(_that);case LoadLoginIdentitiesLoading() when loading != null:
return loading(_that);case LoadLoginIdentitiesSuccess() when success != null:
return success(_that);case LoadLoginIdentitiesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadLoginIdentitiesInitial value)  initial,required TResult Function( LoadLoginIdentitiesLoading value)  loading,required TResult Function( LoadLoginIdentitiesSuccess value)  success,required TResult Function( LoadLoginIdentitiesFailure value)  failure,}){
final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial():
return initial(_that);case LoadLoginIdentitiesLoading():
return loading(_that);case LoadLoginIdentitiesSuccess():
return success(_that);case LoadLoginIdentitiesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadLoginIdentitiesInitial value)?  initial,TResult? Function( LoadLoginIdentitiesLoading value)?  loading,TResult? Function( LoadLoginIdentitiesSuccess value)?  success,TResult? Function( LoadLoginIdentitiesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial() when initial != null:
return initial(_that);case LoadLoginIdentitiesLoading() when loading != null:
return loading(_that);case LoadLoginIdentitiesSuccess() when success != null:
return success(_that);case LoadLoginIdentitiesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LoginIdentities loginIdentities,  SelectedLoginIdentity? selectedLoginIdentity)?  success,TResult Function( Exception exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial() when initial != null:
return initial();case LoadLoginIdentitiesLoading() when loading != null:
return loading();case LoadLoginIdentitiesSuccess() when success != null:
return success(_that.loginIdentities,_that.selectedLoginIdentity);case LoadLoginIdentitiesFailure() when failure != null:
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LoginIdentities loginIdentities,  SelectedLoginIdentity? selectedLoginIdentity)  success,required TResult Function( Exception exception)  failure,}) {final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial():
return initial();case LoadLoginIdentitiesLoading():
return loading();case LoadLoginIdentitiesSuccess():
return success(_that.loginIdentities,_that.selectedLoginIdentity);case LoadLoginIdentitiesFailure():
return failure(_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LoginIdentities loginIdentities,  SelectedLoginIdentity? selectedLoginIdentity)?  success,TResult? Function( Exception exception)?  failure,}) {final _that = this;
switch (_that) {
case LoadLoginIdentitiesInitial() when initial != null:
return initial();case LoadLoginIdentitiesLoading() when loading != null:
return loading();case LoadLoginIdentitiesSuccess() when success != null:
return success(_that.loginIdentities,_that.selectedLoginIdentity);case LoadLoginIdentitiesFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class LoadLoginIdentitiesInitial implements LoadLoginIdentitiesState {
  const LoadLoginIdentitiesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLoginIdentitiesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoadLoginIdentitiesState.initial()';
}


}




/// @nodoc


class LoadLoginIdentitiesLoading implements LoadLoginIdentitiesState {
  const LoadLoginIdentitiesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLoginIdentitiesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoadLoginIdentitiesState.loading()';
}


}




/// @nodoc


class LoadLoginIdentitiesSuccess implements LoadLoginIdentitiesState {
  const LoadLoginIdentitiesSuccess({required this.loginIdentities, required this.selectedLoginIdentity});
  

 final  LoginIdentities loginIdentities;
/// The login identity and server currently selected by the application.
///
/// `null` when no login identity is selected.
 final  SelectedLoginIdentity? selectedLoginIdentity;

/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadLoginIdentitiesSuccessCopyWith<LoadLoginIdentitiesSuccess> get copyWith => _$LoadLoginIdentitiesSuccessCopyWithImpl<LoadLoginIdentitiesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLoginIdentitiesSuccess&&(identical(other.loginIdentities, loginIdentities) || other.loginIdentities == loginIdentities)&&(identical(other.selectedLoginIdentity, selectedLoginIdentity) || other.selectedLoginIdentity == selectedLoginIdentity));
}


@override
int get hashCode => Object.hash(runtimeType,loginIdentities,selectedLoginIdentity);

@override
String toString() {
  return 'LoadLoginIdentitiesState.success(loginIdentities: $loginIdentities, selectedLoginIdentity: $selectedLoginIdentity)';
}


}

/// @nodoc
abstract mixin class $LoadLoginIdentitiesSuccessCopyWith<$Res> implements $LoadLoginIdentitiesStateCopyWith<$Res> {
  factory $LoadLoginIdentitiesSuccessCopyWith(LoadLoginIdentitiesSuccess value, $Res Function(LoadLoginIdentitiesSuccess) _then) = _$LoadLoginIdentitiesSuccessCopyWithImpl;
@useResult
$Res call({
 LoginIdentities loginIdentities, SelectedLoginIdentity? selectedLoginIdentity
});


$LoginIdentitiesCopyWith<$Res> get loginIdentities;$SelectedLoginIdentityCopyWith<$Res>? get selectedLoginIdentity;

}
/// @nodoc
class _$LoadLoginIdentitiesSuccessCopyWithImpl<$Res>
    implements $LoadLoginIdentitiesSuccessCopyWith<$Res> {
  _$LoadLoginIdentitiesSuccessCopyWithImpl(this._self, this._then);

  final LoadLoginIdentitiesSuccess _self;
  final $Res Function(LoadLoginIdentitiesSuccess) _then;

/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginIdentities = null,Object? selectedLoginIdentity = freezed,}) {
  return _then(LoadLoginIdentitiesSuccess(
loginIdentities: null == loginIdentities ? _self.loginIdentities : loginIdentities // ignore: cast_nullable_to_non_nullable
as LoginIdentities,selectedLoginIdentity: freezed == selectedLoginIdentity ? _self.selectedLoginIdentity : selectedLoginIdentity // ignore: cast_nullable_to_non_nullable
as SelectedLoginIdentity?,
  ));
}

/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginIdentitiesCopyWith<$Res> get loginIdentities {
  
  return $LoginIdentitiesCopyWith<$Res>(_self.loginIdentities, (value) {
    return _then(_self.copyWith(loginIdentities: value));
  });
}/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectedLoginIdentityCopyWith<$Res>? get selectedLoginIdentity {
    if (_self.selectedLoginIdentity == null) {
    return null;
  }

  return $SelectedLoginIdentityCopyWith<$Res>(_self.selectedLoginIdentity!, (value) {
    return _then(_self.copyWith(selectedLoginIdentity: value));
  });
}
}

/// @nodoc


class LoadLoginIdentitiesFailure implements LoadLoginIdentitiesState {
  const LoadLoginIdentitiesFailure(this.exception);
  

 final  Exception exception;

/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadLoginIdentitiesFailureCopyWith<LoadLoginIdentitiesFailure> get copyWith => _$LoadLoginIdentitiesFailureCopyWithImpl<LoadLoginIdentitiesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadLoginIdentitiesFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'LoadLoginIdentitiesState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $LoadLoginIdentitiesFailureCopyWith<$Res> implements $LoadLoginIdentitiesStateCopyWith<$Res> {
  factory $LoadLoginIdentitiesFailureCopyWith(LoadLoginIdentitiesFailure value, $Res Function(LoadLoginIdentitiesFailure) _then) = _$LoadLoginIdentitiesFailureCopyWithImpl;
@useResult
$Res call({
 Exception exception
});




}
/// @nodoc
class _$LoadLoginIdentitiesFailureCopyWithImpl<$Res>
    implements $LoadLoginIdentitiesFailureCopyWith<$Res> {
  _$LoadLoginIdentitiesFailureCopyWithImpl(this._self, this._then);

  final LoadLoginIdentitiesFailure _self;
  final $Res Function(LoadLoginIdentitiesFailure) _then;

/// Create a copy of LoadLoginIdentitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(LoadLoginIdentitiesFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as Exception,
  ));
}


}

/// @nodoc
mixin _$LogoutState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogoutState()';
}


}

/// @nodoc
class $LogoutStateCopyWith<$Res>  {
$LogoutStateCopyWith(LogoutState _, $Res Function(LogoutState) __);
}


/// Adds pattern-matching-related methods to [LogoutState].
extension LogoutStatePatterns on LogoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LogoutInitial value)?  initial,TResult Function( LogoutLoading value)?  loading,TResult Function( LogoutSuccess value)?  success,TResult Function( LogoutFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LogoutInitial() when initial != null:
return initial(_that);case LogoutLoading() when loading != null:
return loading(_that);case LogoutSuccess() when success != null:
return success(_that);case LogoutFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LogoutInitial value)  initial,required TResult Function( LogoutLoading value)  loading,required TResult Function( LogoutSuccess value)  success,required TResult Function( LogoutFailure value)  failure,}){
final _that = this;
switch (_that) {
case LogoutInitial():
return initial(_that);case LogoutLoading():
return loading(_that);case LogoutSuccess():
return success(_that);case LogoutFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LogoutInitial value)?  initial,TResult? Function( LogoutLoading value)?  loading,TResult? Function( LogoutSuccess value)?  success,TResult? Function( LogoutFailure value)?  failure,}){
final _that = this;
switch (_that) {
case LogoutInitial() when initial != null:
return initial(_that);case LogoutLoading() when loading != null:
return loading(_that);case LogoutSuccess() when success != null:
return success(_that);case LogoutFailure() when failure != null:
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
case LogoutInitial() when initial != null:
return initial();case LogoutLoading() when loading != null:
return loading();case LogoutSuccess() when success != null:
return success();case LogoutFailure() when failure != null:
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
case LogoutInitial():
return initial();case LogoutLoading():
return loading();case LogoutSuccess():
return success();case LogoutFailure():
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
case LogoutInitial() when initial != null:
return initial();case LogoutLoading() when loading != null:
return loading();case LogoutSuccess() when success != null:
return success();case LogoutFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class LogoutInitial implements LogoutState {
  const LogoutInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogoutState.initial()';
}


}




/// @nodoc


class LogoutLoading implements LogoutState {
  const LogoutLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogoutState.loading()';
}


}




/// @nodoc


class LogoutSuccess implements LogoutState {
  const LogoutSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogoutState.success()';
}


}




/// @nodoc


class LogoutFailure implements LogoutState {
  const LogoutFailure(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of LogoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogoutFailureCopyWith<LogoutFailure> get copyWith => _$LogoutFailureCopyWithImpl<LogoutFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'LogoutState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $LogoutFailureCopyWith<$Res> implements $LogoutStateCopyWith<$Res> {
  factory $LogoutFailureCopyWith(LogoutFailure value, $Res Function(LogoutFailure) _then) = _$LogoutFailureCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$LogoutFailureCopyWithImpl<$Res>
    implements $LogoutFailureCopyWith<$Res> {
  _$LogoutFailureCopyWithImpl(this._self, this._then);

  final LogoutFailure _self;
  final $Res Function(LogoutFailure) _then;

/// Create a copy of LogoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(LogoutFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

/// @nodoc
mixin _$SelectedLoginIdentity {

 LoginIdentity get loginIdentity; Server get server;
/// Create a copy of SelectedLoginIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedLoginIdentityCopyWith<SelectedLoginIdentity> get copyWith => _$SelectedLoginIdentityCopyWithImpl<SelectedLoginIdentity>(this as SelectedLoginIdentity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedLoginIdentity&&(identical(other.loginIdentity, loginIdentity) || other.loginIdentity == loginIdentity)&&(identical(other.server, server) || other.server == server));
}


@override
int get hashCode => Object.hash(runtimeType,loginIdentity,server);

@override
String toString() {
  return 'SelectedLoginIdentity(loginIdentity: $loginIdentity, server: $server)';
}


}

/// @nodoc
abstract mixin class $SelectedLoginIdentityCopyWith<$Res>  {
  factory $SelectedLoginIdentityCopyWith(SelectedLoginIdentity value, $Res Function(SelectedLoginIdentity) _then) = _$SelectedLoginIdentityCopyWithImpl;
@useResult
$Res call({
 LoginIdentity loginIdentity, Server server
});




}
/// @nodoc
class _$SelectedLoginIdentityCopyWithImpl<$Res>
    implements $SelectedLoginIdentityCopyWith<$Res> {
  _$SelectedLoginIdentityCopyWithImpl(this._self, this._then);

  final SelectedLoginIdentity _self;
  final $Res Function(SelectedLoginIdentity) _then;

/// Create a copy of SelectedLoginIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loginIdentity = null,Object? server = null,}) {
  return _then(SelectedLoginIdentity(
loginIdentity: null == loginIdentity ? _self.loginIdentity : loginIdentity // ignore: cast_nullable_to_non_nullable
as LoginIdentity,server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server,
  ));
}

}



/// @nodoc


class _SelectedLoginIdentity extends SelectedLoginIdentity {
  const _SelectedLoginIdentity({required this.loginIdentity, required this.server}): super(loginIdentity: loginIdentity, server: server);
  

@override final  LoginIdentity loginIdentity;
@override final  Server server;

/// Create a copy of SelectedLoginIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedLoginIdentityCopyWith<_SelectedLoginIdentity> get copyWith => __$SelectedLoginIdentityCopyWithImpl<_SelectedLoginIdentity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedLoginIdentity&&(identical(other.loginIdentity, loginIdentity) || other.loginIdentity == loginIdentity)&&(identical(other.server, server) || other.server == server));
}


@override
int get hashCode => Object.hash(runtimeType,loginIdentity,server);

@override
String toString() {
  return 'SelectedLoginIdentity(loginIdentity: $loginIdentity, server: $server)';
}


}

/// @nodoc
abstract mixin class _$SelectedLoginIdentityCopyWith<$Res> implements $SelectedLoginIdentityCopyWith<$Res> {
  factory _$SelectedLoginIdentityCopyWith(_SelectedLoginIdentity value, $Res Function(_SelectedLoginIdentity) _then) = __$SelectedLoginIdentityCopyWithImpl;
@override @useResult
$Res call({
 LoginIdentity loginIdentity, Server server
});




}
/// @nodoc
class __$SelectedLoginIdentityCopyWithImpl<$Res>
    implements _$SelectedLoginIdentityCopyWith<$Res> {
  __$SelectedLoginIdentityCopyWithImpl(this._self, this._then);

  final _SelectedLoginIdentity _self;
  final $Res Function(_SelectedLoginIdentity) _then;

/// Create a copy of SelectedLoginIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loginIdentity = null,Object? server = null,}) {
  return _then(_SelectedLoginIdentity(
loginIdentity: null == loginIdentity ? _self.loginIdentity : loginIdentity // ignore: cast_nullable_to_non_nullable
as LoginIdentity,server: null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as Server,
  ));
}


}

/// @nodoc
mixin _$LoginIdentityEffect {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginIdentityEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginIdentityEffect()';
}


}

/// @nodoc
class $LoginIdentityEffectCopyWith<$Res>  {
$LoginIdentityEffectCopyWith(LoginIdentityEffect _, $Res Function(LoginIdentityEffect) __);
}


/// Adds pattern-matching-related methods to [LoginIdentityEffect].
extension LoginIdentityEffectPatterns on LoginIdentityEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LogoutConfirmationRequired value)?  confirmationRequired,TResult Function( LogoutFailureMessage value)?  logoutFailureMessage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LogoutConfirmationRequired() when confirmationRequired != null:
return confirmationRequired(_that);case LogoutFailureMessage() when logoutFailureMessage != null:
return logoutFailureMessage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LogoutConfirmationRequired value)  confirmationRequired,required TResult Function( LogoutFailureMessage value)  logoutFailureMessage,}){
final _that = this;
switch (_that) {
case LogoutConfirmationRequired():
return confirmationRequired(_that);case LogoutFailureMessage():
return logoutFailureMessage(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LogoutConfirmationRequired value)?  confirmationRequired,TResult? Function( LogoutFailureMessage value)?  logoutFailureMessage,}){
final _that = this;
switch (_that) {
case LogoutConfirmationRequired() when confirmationRequired != null:
return confirmationRequired(_that);case LogoutFailureMessage() when logoutFailureMessage != null:
return logoutFailureMessage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool isLoginDisabled)?  confirmationRequired,TResult Function( ApiRequestFailure failure)?  logoutFailureMessage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LogoutConfirmationRequired() when confirmationRequired != null:
return confirmationRequired(_that.isLoginDisabled);case LogoutFailureMessage() when logoutFailureMessage != null:
return logoutFailureMessage(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool isLoginDisabled)  confirmationRequired,required TResult Function( ApiRequestFailure failure)  logoutFailureMessage,}) {final _that = this;
switch (_that) {
case LogoutConfirmationRequired():
return confirmationRequired(_that.isLoginDisabled);case LogoutFailureMessage():
return logoutFailureMessage(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool isLoginDisabled)?  confirmationRequired,TResult? Function( ApiRequestFailure failure)?  logoutFailureMessage,}) {final _that = this;
switch (_that) {
case LogoutConfirmationRequired() when confirmationRequired != null:
return confirmationRequired(_that.isLoginDisabled);case LogoutFailureMessage() when logoutFailureMessage != null:
return logoutFailureMessage(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class LogoutConfirmationRequired implements LoginIdentityEffect {
  const LogoutConfirmationRequired({required this.isLoginDisabled});
  

 final  bool isLoginDisabled;

/// Create a copy of LoginIdentityEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogoutConfirmationRequiredCopyWith<LogoutConfirmationRequired> get copyWith => _$LogoutConfirmationRequiredCopyWithImpl<LogoutConfirmationRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutConfirmationRequired&&(identical(other.isLoginDisabled, isLoginDisabled) || other.isLoginDisabled == isLoginDisabled));
}


@override
int get hashCode => Object.hash(runtimeType,isLoginDisabled);

@override
String toString() {
  return 'LoginIdentityEffect.confirmationRequired(isLoginDisabled: $isLoginDisabled)';
}


}

/// @nodoc
abstract mixin class $LogoutConfirmationRequiredCopyWith<$Res> implements $LoginIdentityEffectCopyWith<$Res> {
  factory $LogoutConfirmationRequiredCopyWith(LogoutConfirmationRequired value, $Res Function(LogoutConfirmationRequired) _then) = _$LogoutConfirmationRequiredCopyWithImpl;
@useResult
$Res call({
 bool isLoginDisabled
});




}
/// @nodoc
class _$LogoutConfirmationRequiredCopyWithImpl<$Res>
    implements $LogoutConfirmationRequiredCopyWith<$Res> {
  _$LogoutConfirmationRequiredCopyWithImpl(this._self, this._then);

  final LogoutConfirmationRequired _self;
  final $Res Function(LogoutConfirmationRequired) _then;

/// Create a copy of LoginIdentityEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isLoginDisabled = null,}) {
  return _then(LogoutConfirmationRequired(
isLoginDisabled: null == isLoginDisabled ? _self.isLoginDisabled : isLoginDisabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class LogoutFailureMessage implements LoginIdentityEffect {
  const LogoutFailureMessage(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of LoginIdentityEffect
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogoutFailureMessageCopyWith<LogoutFailureMessage> get copyWith => _$LogoutFailureMessageCopyWithImpl<LogoutFailureMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutFailureMessage&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'LoginIdentityEffect.logoutFailureMessage(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $LogoutFailureMessageCopyWith<$Res> implements $LoginIdentityEffectCopyWith<$Res> {
  factory $LogoutFailureMessageCopyWith(LogoutFailureMessage value, $Res Function(LogoutFailureMessage) _then) = _$LogoutFailureMessageCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$LogoutFailureMessageCopyWithImpl<$Res>
    implements $LogoutFailureMessageCopyWith<$Res> {
  _$LogoutFailureMessageCopyWithImpl(this._self, this._then);

  final LogoutFailureMessage _self;
  final $Res Function(LogoutFailureMessage) _then;

/// Create a copy of LoginIdentityEffect
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(LogoutFailureMessage(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

// dart format on
