// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_identities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginIdentities {

/// The [LoginIdentity.id] of the selected [LoginIdentity].
/// `null` if none has been selected.
 int? get selectedLoginIdentityId;/// Servers configured for the local users.
///
/// Multiple [LoginIdentity]s can reference the same server.
 List<Server> get servers;/// Login identities configured in this app installation.
 List<LoginIdentity> get loginIdentities;
/// Create a copy of LoginIdentities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginIdentitiesCopyWith<LoginIdentities> get copyWith => _$LoginIdentitiesCopyWithImpl<LoginIdentities>(this as LoginIdentities, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginIdentities&&(identical(other.selectedLoginIdentityId, selectedLoginIdentityId) || other.selectedLoginIdentityId == selectedLoginIdentityId)&&const DeepCollectionEquality().equals(other.servers, servers)&&const DeepCollectionEquality().equals(other.loginIdentities, loginIdentities));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLoginIdentityId,const DeepCollectionEquality().hash(servers),const DeepCollectionEquality().hash(loginIdentities));

@override
String toString() {
  return 'LoginIdentities(selectedLoginIdentityId: $selectedLoginIdentityId, servers: $servers, loginIdentities: $loginIdentities)';
}


}

/// @nodoc
abstract mixin class $LoginIdentitiesCopyWith<$Res>  {
  factory $LoginIdentitiesCopyWith(LoginIdentities value, $Res Function(LoginIdentities) _then) = _$LoginIdentitiesCopyWithImpl;
@useResult
$Res call({
 int? selectedLoginIdentityId, List<Server> servers, List<LoginIdentity> loginIdentities
});




}
/// @nodoc
class _$LoginIdentitiesCopyWithImpl<$Res>
    implements $LoginIdentitiesCopyWith<$Res> {
  _$LoginIdentitiesCopyWithImpl(this._self, this._then);

  final LoginIdentities _self;
  final $Res Function(LoginIdentities) _then;

/// Create a copy of LoginIdentities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedLoginIdentityId = freezed,Object? servers = null,Object? loginIdentities = null,}) {
  return _then(LoginIdentities(
selectedLoginIdentityId: freezed == selectedLoginIdentityId ? _self.selectedLoginIdentityId : selectedLoginIdentityId // ignore: cast_nullable_to_non_nullable
as int?,servers: null == servers ? _self.servers : servers // ignore: cast_nullable_to_non_nullable
as List<Server>,loginIdentities: null == loginIdentities ? _self.loginIdentities : loginIdentities // ignore: cast_nullable_to_non_nullable
as List<LoginIdentity>,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginIdentities].
extension LoginIdentitiesPatterns on LoginIdentities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginIdentities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginIdentities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginIdentities value)  $default,){
final _that = this;
switch (_that) {
case _LoginIdentities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginIdentities value)?  $default,){
final _that = this;
switch (_that) {
case _LoginIdentities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? selectedLoginIdentityId,  List<Server> servers,  List<LoginIdentity> loginIdentities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginIdentities() when $default != null:
return $default(_that.selectedLoginIdentityId,_that.servers,_that.loginIdentities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? selectedLoginIdentityId,  List<Server> servers,  List<LoginIdentity> loginIdentities)  $default,) {final _that = this;
switch (_that) {
case _LoginIdentities():
return $default(_that.selectedLoginIdentityId,_that.servers,_that.loginIdentities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? selectedLoginIdentityId,  List<Server> servers,  List<LoginIdentity> loginIdentities)?  $default,) {final _that = this;
switch (_that) {
case _LoginIdentities() when $default != null:
return $default(_that.selectedLoginIdentityId,_that.servers,_that.loginIdentities);case _:
  return null;

}
}

}

/// @nodoc


class _LoginIdentities extends LoginIdentities {
  const _LoginIdentities({required this.selectedLoginIdentityId, required  List<Server> servers, required  List<LoginIdentity> loginIdentities}): _servers = servers,_loginIdentities = loginIdentities,super(selectedLoginIdentityId: selectedLoginIdentityId, servers: servers, loginIdentities: loginIdentities);
  

/// The [LoginIdentity.id] of the selected [LoginIdentity].
/// `null` if none has been selected.
@override final  int? selectedLoginIdentityId;
/// Servers configured for the local users.
///
/// Multiple [LoginIdentity]s can reference the same server.
 final  List<Server> _servers;
/// Servers configured for the local users.
///
/// Multiple [LoginIdentity]s can reference the same server.
@override List<Server> get servers {
  if (_servers is EqualUnmodifiableListView) return _servers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_servers);
}

/// Login identities configured in this app installation.
 final  List<LoginIdentity> _loginIdentities;
/// Login identities configured in this app installation.
@override List<LoginIdentity> get loginIdentities {
  if (_loginIdentities is EqualUnmodifiableListView) return _loginIdentities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_loginIdentities);
}


/// Create a copy of LoginIdentities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginIdentitiesCopyWith<_LoginIdentities> get copyWith => __$LoginIdentitiesCopyWithImpl<_LoginIdentities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginIdentities&&(identical(other.selectedLoginIdentityId, selectedLoginIdentityId) || other.selectedLoginIdentityId == selectedLoginIdentityId)&&const DeepCollectionEquality().equals(other._servers, _servers)&&const DeepCollectionEquality().equals(other._loginIdentities, _loginIdentities));
}


@override
int get hashCode => Object.hash(runtimeType,selectedLoginIdentityId,const DeepCollectionEquality().hash(_servers),const DeepCollectionEquality().hash(_loginIdentities));

@override
String toString() {
  return 'LoginIdentities(selectedLoginIdentityId: $selectedLoginIdentityId, servers: $servers, loginIdentities: $loginIdentities)';
}


}

/// @nodoc
abstract mixin class _$LoginIdentitiesCopyWith<$Res> implements $LoginIdentitiesCopyWith<$Res> {
  factory _$LoginIdentitiesCopyWith(_LoginIdentities value, $Res Function(_LoginIdentities) _then) = __$LoginIdentitiesCopyWithImpl;
@override @useResult
$Res call({
 int? selectedLoginIdentityId, List<Server> servers, List<LoginIdentity> loginIdentities
});




}
/// @nodoc
class __$LoginIdentitiesCopyWithImpl<$Res>
    implements _$LoginIdentitiesCopyWith<$Res> {
  __$LoginIdentitiesCopyWithImpl(this._self, this._then);

  final _LoginIdentities _self;
  final $Res Function(_LoginIdentities) _then;

/// Create a copy of LoginIdentities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedLoginIdentityId = freezed,Object? servers = null,Object? loginIdentities = null,}) {
  return _then(_LoginIdentities(
selectedLoginIdentityId: freezed == selectedLoginIdentityId ? _self.selectedLoginIdentityId : selectedLoginIdentityId // ignore: cast_nullable_to_non_nullable
as int?,servers: null == servers ? _self._servers : servers // ignore: cast_nullable_to_non_nullable
as List<Server>,loginIdentities: null == loginIdentities ? _self._loginIdentities : loginIdentities // ignore: cast_nullable_to_non_nullable
as List<LoginIdentity>,
  ));
}


}

// dart format on
