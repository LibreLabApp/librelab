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





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginIdentityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginIdentityState()';
}


}

/// @nodoc
class $LoginIdentityStateCopyWith<$Res>  {
$LoginIdentityStateCopyWith(LoginIdentityState _, $Res Function(LoginIdentityState) __);
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Loading value)?  loading,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Loading value)  loading,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Loading():
return loading(_that);case Success():
return success(_that);case Failure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Loading value)?  loading,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Loading() when loading != null:
return loading(_that);case Success() when success != null:
return success(_that);case Failure() when failure != null:
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
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.loginIdentities,_that.selectedLoginIdentity);case Failure() when failure != null:
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
case Initial():
return initial();case Loading():
return loading();case Success():
return success(_that.loginIdentities,_that.selectedLoginIdentity);case Failure():
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
case Initial() when initial != null:
return initial();case Loading() when loading != null:
return loading();case Success() when success != null:
return success(_that.loginIdentities,_that.selectedLoginIdentity);case Failure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements LoginIdentityState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginIdentityState.initial()';
}


}




/// @nodoc


class Loading implements LoginIdentityState {
  const Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginIdentityState.loading()';
}


}




/// @nodoc


class Success implements LoginIdentityState {
  const Success({required this.loginIdentities, required this.selectedLoginIdentity});
  

 final  LoginIdentities loginIdentities;
/// The login identity and server currently selected by the application.
///
/// `null` when no login identity is selected.
 final  SelectedLoginIdentity? selectedLoginIdentity;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.loginIdentities, loginIdentities) || other.loginIdentities == loginIdentities)&&(identical(other.selectedLoginIdentity, selectedLoginIdentity) || other.selectedLoginIdentity == selectedLoginIdentity));
}


@override
int get hashCode => Object.hash(runtimeType,loginIdentities,selectedLoginIdentity);

@override
String toString() {
  return 'LoginIdentityState.success(loginIdentities: $loginIdentities, selectedLoginIdentity: $selectedLoginIdentity)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $LoginIdentityStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 LoginIdentities loginIdentities, SelectedLoginIdentity? selectedLoginIdentity
});


$LoginIdentitiesCopyWith<$Res> get loginIdentities;$SelectedLoginIdentityCopyWith<$Res>? get selectedLoginIdentity;

}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? loginIdentities = null,Object? selectedLoginIdentity = freezed,}) {
  return _then(Success(
loginIdentities: null == loginIdentities ? _self.loginIdentities : loginIdentities // ignore: cast_nullable_to_non_nullable
as LoginIdentities,selectedLoginIdentity: freezed == selectedLoginIdentity ? _self.selectedLoginIdentity : selectedLoginIdentity // ignore: cast_nullable_to_non_nullable
as SelectedLoginIdentity?,
  ));
}

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginIdentitiesCopyWith<$Res> get loginIdentities {
  
  return $LoginIdentitiesCopyWith<$Res>(_self.loginIdentities, (value) {
    return _then(_self.copyWith(loginIdentities: value));
  });
}/// Create a copy of LoginIdentityState
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


class Failure implements LoginIdentityState {
  const Failure(this.exception);
  

 final  Exception exception;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'LoginIdentityState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $LoginIdentityStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 Exception exception
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of LoginIdentityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(Failure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as Exception,
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

// dart format on
