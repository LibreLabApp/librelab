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

/// Defaults to [ServerSelectionMethod.manual] on web due to lack of
/// native mDNS service discovery support.
/// Must not use [ServerSelectionMethod.localNetworkDiscovery] on web.
 ServerSelectionMethod get selectionMethod;/// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
 String? get manualServerAddress; LocalDiscoveryState get discoveryState; ServerCompatibilityCheckState get compatibilityCheckState;
/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerSelectionStateCopyWith<ServerSelectionState> get copyWith => _$ServerSelectionStateCopyWithImpl<ServerSelectionState>(this as ServerSelectionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSelectionState&&(identical(other.selectionMethod, selectionMethod) || other.selectionMethod == selectionMethod)&&(identical(other.manualServerAddress, manualServerAddress) || other.manualServerAddress == manualServerAddress)&&(identical(other.discoveryState, discoveryState) || other.discoveryState == discoveryState)&&(identical(other.compatibilityCheckState, compatibilityCheckState) || other.compatibilityCheckState == compatibilityCheckState));
}


@override
int get hashCode => Object.hash(runtimeType,selectionMethod,manualServerAddress,discoveryState,compatibilityCheckState);

@override
String toString() {
  return 'ServerSelectionState(selectionMethod: $selectionMethod, manualServerAddress: $manualServerAddress, discoveryState: $discoveryState, compatibilityCheckState: $compatibilityCheckState)';
}


}

/// @nodoc
abstract mixin class $ServerSelectionStateCopyWith<$Res>  {
  factory $ServerSelectionStateCopyWith(ServerSelectionState value, $Res Function(ServerSelectionState) _then) = _$ServerSelectionStateCopyWithImpl;
@useResult
$Res call({
 ServerSelectionMethod selectionMethod, String? manualServerAddress, LocalDiscoveryState discoveryState, ServerCompatibilityCheckState compatibilityCheckState
});


$LocalDiscoveryStateCopyWith<$Res> get discoveryState;$ServerCompatibilityCheckStateCopyWith<$Res> get compatibilityCheckState;

}
/// @nodoc
class _$ServerSelectionStateCopyWithImpl<$Res>
    implements $ServerSelectionStateCopyWith<$Res> {
  _$ServerSelectionStateCopyWithImpl(this._self, this._then);

  final ServerSelectionState _self;
  final $Res Function(ServerSelectionState) _then;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectionMethod = null,Object? manualServerAddress = freezed,Object? discoveryState = null,Object? compatibilityCheckState = null,}) {
  return _then(ServerSelectionState(
selectionMethod: null == selectionMethod ? _self.selectionMethod : selectionMethod // ignore: cast_nullable_to_non_nullable
as ServerSelectionMethod,manualServerAddress: freezed == manualServerAddress ? _self.manualServerAddress : manualServerAddress // ignore: cast_nullable_to_non_nullable
as String?,discoveryState: null == discoveryState ? _self.discoveryState : discoveryState // ignore: cast_nullable_to_non_nullable
as LocalDiscoveryState,compatibilityCheckState: null == compatibilityCheckState ? _self.compatibilityCheckState : compatibilityCheckState // ignore: cast_nullable_to_non_nullable
as ServerCompatibilityCheckState,
  ));
}
/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalDiscoveryStateCopyWith<$Res> get discoveryState {
  
  return $LocalDiscoveryStateCopyWith<$Res>(_self.discoveryState, (value) {
    return _then(_self.copyWith(discoveryState: value));
  });
}/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerCompatibilityCheckStateCopyWith<$Res> get compatibilityCheckState {
  
  return $ServerCompatibilityCheckStateCopyWith<$Res>(_self.compatibilityCheckState, (value) {
    return _then(_self.copyWith(compatibilityCheckState: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServerSelectionMethod selectionMethod,  String? manualServerAddress,  LocalDiscoveryState discoveryState,  ServerCompatibilityCheckState compatibilityCheckState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
return $default(_that.selectionMethod,_that.manualServerAddress,_that.discoveryState,_that.compatibilityCheckState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServerSelectionMethod selectionMethod,  String? manualServerAddress,  LocalDiscoveryState discoveryState,  ServerCompatibilityCheckState compatibilityCheckState)  $default,) {final _that = this;
switch (_that) {
case _ServerSelectionState():
return $default(_that.selectionMethod,_that.manualServerAddress,_that.discoveryState,_that.compatibilityCheckState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServerSelectionMethod selectionMethod,  String? manualServerAddress,  LocalDiscoveryState discoveryState,  ServerCompatibilityCheckState compatibilityCheckState)?  $default,) {final _that = this;
switch (_that) {
case _ServerSelectionState() when $default != null:
return $default(_that.selectionMethod,_that.manualServerAddress,_that.discoveryState,_that.compatibilityCheckState);case _:
  return null;

}
}

}

/// @nodoc


class _ServerSelectionState extends ServerSelectionState {
  const _ServerSelectionState({required this.selectionMethod, required this.manualServerAddress, required this.discoveryState, required this.compatibilityCheckState}): super(selectionMethod: selectionMethod, manualServerAddress: manualServerAddress, discoveryState: discoveryState, compatibilityCheckState: compatibilityCheckState);
  

/// Defaults to [ServerSelectionMethod.manual] on web due to lack of
/// native mDNS service discovery support.
/// Must not use [ServerSelectionMethod.localNetworkDiscovery] on web.
@override final  ServerSelectionMethod selectionMethod;
/// Should be only used if [selectionMethod] is [ServerSelectionMethod.manual].
@override final  String? manualServerAddress;
@override final  LocalDiscoveryState discoveryState;
@override final  ServerCompatibilityCheckState compatibilityCheckState;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerSelectionStateCopyWith<_ServerSelectionState> get copyWith => __$ServerSelectionStateCopyWithImpl<_ServerSelectionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerSelectionState&&(identical(other.selectionMethod, selectionMethod) || other.selectionMethod == selectionMethod)&&(identical(other.manualServerAddress, manualServerAddress) || other.manualServerAddress == manualServerAddress)&&(identical(other.discoveryState, discoveryState) || other.discoveryState == discoveryState)&&(identical(other.compatibilityCheckState, compatibilityCheckState) || other.compatibilityCheckState == compatibilityCheckState));
}


@override
int get hashCode => Object.hash(runtimeType,selectionMethod,manualServerAddress,discoveryState,compatibilityCheckState);

@override
String toString() {
  return 'ServerSelectionState(selectionMethod: $selectionMethod, manualServerAddress: $manualServerAddress, discoveryState: $discoveryState, compatibilityCheckState: $compatibilityCheckState)';
}


}

/// @nodoc
abstract mixin class _$ServerSelectionStateCopyWith<$Res> implements $ServerSelectionStateCopyWith<$Res> {
  factory _$ServerSelectionStateCopyWith(_ServerSelectionState value, $Res Function(_ServerSelectionState) _then) = __$ServerSelectionStateCopyWithImpl;
@override @useResult
$Res call({
 ServerSelectionMethod selectionMethod, String? manualServerAddress, LocalDiscoveryState discoveryState, ServerCompatibilityCheckState compatibilityCheckState
});


@override $LocalDiscoveryStateCopyWith<$Res> get discoveryState;@override $ServerCompatibilityCheckStateCopyWith<$Res> get compatibilityCheckState;

}
/// @nodoc
class __$ServerSelectionStateCopyWithImpl<$Res>
    implements _$ServerSelectionStateCopyWith<$Res> {
  __$ServerSelectionStateCopyWithImpl(this._self, this._then);

  final _ServerSelectionState _self;
  final $Res Function(_ServerSelectionState) _then;

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectionMethod = null,Object? manualServerAddress = freezed,Object? discoveryState = null,Object? compatibilityCheckState = null,}) {
  return _then(_ServerSelectionState(
selectionMethod: null == selectionMethod ? _self.selectionMethod : selectionMethod // ignore: cast_nullable_to_non_nullable
as ServerSelectionMethod,manualServerAddress: freezed == manualServerAddress ? _self.manualServerAddress : manualServerAddress // ignore: cast_nullable_to_non_nullable
as String?,discoveryState: null == discoveryState ? _self.discoveryState : discoveryState // ignore: cast_nullable_to_non_nullable
as LocalDiscoveryState,compatibilityCheckState: null == compatibilityCheckState ? _self.compatibilityCheckState : compatibilityCheckState // ignore: cast_nullable_to_non_nullable
as ServerCompatibilityCheckState,
  ));
}

/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalDiscoveryStateCopyWith<$Res> get discoveryState {
  
  return $LocalDiscoveryStateCopyWith<$Res>(_self.discoveryState, (value) {
    return _then(_self.copyWith(discoveryState: value));
  });
}/// Create a copy of ServerSelectionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServerCompatibilityCheckStateCopyWith<$Res> get compatibilityCheckState {
  
  return $ServerCompatibilityCheckStateCopyWith<$Res>(_self.compatibilityCheckState, (value) {
    return _then(_self.copyWith(compatibilityCheckState: value));
  });
}
}

/// @nodoc
mixin _$LocalDiscoveryState {

 List<DiscoveredServer> get discoveredServers;/// Should be only used if [ServerSelectionState.selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery].
 String? get selectedServerId; bool get isLoading; bool get hasLoadedOnce;
/// Create a copy of LocalDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalDiscoveryStateCopyWith<LocalDiscoveryState> get copyWith => _$LocalDiscoveryStateCopyWithImpl<LocalDiscoveryState>(this as LocalDiscoveryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalDiscoveryState&&const DeepCollectionEquality().equals(other.discoveredServers, discoveredServers)&&(identical(other.selectedServerId, selectedServerId) || other.selectedServerId == selectedServerId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasLoadedOnce, hasLoadedOnce) || other.hasLoadedOnce == hasLoadedOnce));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(discoveredServers),selectedServerId,isLoading,hasLoadedOnce);

@override
String toString() {
  return 'LocalDiscoveryState(discoveredServers: $discoveredServers, selectedServerId: $selectedServerId, isLoading: $isLoading, hasLoadedOnce: $hasLoadedOnce)';
}


}

/// @nodoc
abstract mixin class $LocalDiscoveryStateCopyWith<$Res>  {
  factory $LocalDiscoveryStateCopyWith(LocalDiscoveryState value, $Res Function(LocalDiscoveryState) _then) = _$LocalDiscoveryStateCopyWithImpl;
@useResult
$Res call({
 List<DiscoveredServer> discoveredServers, String? selectedServerId, bool isLoading, bool hasLoadedOnce
});




}
/// @nodoc
class _$LocalDiscoveryStateCopyWithImpl<$Res>
    implements $LocalDiscoveryStateCopyWith<$Res> {
  _$LocalDiscoveryStateCopyWithImpl(this._self, this._then);

  final LocalDiscoveryState _self;
  final $Res Function(LocalDiscoveryState) _then;

/// Create a copy of LocalDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? discoveredServers = null,Object? selectedServerId = freezed,Object? isLoading = null,Object? hasLoadedOnce = null,}) {
  return _then(LocalDiscoveryState(
discoveredServers: null == discoveredServers ? _self.discoveredServers : discoveredServers // ignore: cast_nullable_to_non_nullable
as List<DiscoveredServer>,selectedServerId: freezed == selectedServerId ? _self.selectedServerId : selectedServerId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedOnce: null == hasLoadedOnce ? _self.hasLoadedOnce : hasLoadedOnce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalDiscoveryState].
extension LocalDiscoveryStatePatterns on LocalDiscoveryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalDiscoveryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalDiscoveryState value)  $default,){
final _that = this;
switch (_that) {
case _LocalDiscoveryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalDiscoveryState value)?  $default,){
final _that = this;
switch (_that) {
case _LocalDiscoveryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DiscoveredServer> discoveredServers,  String? selectedServerId,  bool isLoading,  bool hasLoadedOnce)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalDiscoveryState() when $default != null:
return $default(_that.discoveredServers,_that.selectedServerId,_that.isLoading,_that.hasLoadedOnce);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DiscoveredServer> discoveredServers,  String? selectedServerId,  bool isLoading,  bool hasLoadedOnce)  $default,) {final _that = this;
switch (_that) {
case _LocalDiscoveryState():
return $default(_that.discoveredServers,_that.selectedServerId,_that.isLoading,_that.hasLoadedOnce);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DiscoveredServer> discoveredServers,  String? selectedServerId,  bool isLoading,  bool hasLoadedOnce)?  $default,) {final _that = this;
switch (_that) {
case _LocalDiscoveryState() when $default != null:
return $default(_that.discoveredServers,_that.selectedServerId,_that.isLoading,_that.hasLoadedOnce);case _:
  return null;

}
}

}

/// @nodoc


class _LocalDiscoveryState extends LocalDiscoveryState {
  const _LocalDiscoveryState({required  List<DiscoveredServer> discoveredServers, required this.selectedServerId, required this.isLoading, required this.hasLoadedOnce}): _discoveredServers = discoveredServers,super(discoveredServers: discoveredServers, selectedServerId: selectedServerId, isLoading: isLoading, hasLoadedOnce: hasLoadedOnce);
  

 final  List<DiscoveredServer> _discoveredServers;
@override List<DiscoveredServer> get discoveredServers {
  if (_discoveredServers is EqualUnmodifiableListView) return _discoveredServers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_discoveredServers);
}

/// Should be only used if [ServerSelectionState.selectionMethod] is [ServerSelectionMethod.localNetworkDiscovery].
@override final  String? selectedServerId;
@override final  bool isLoading;
@override final  bool hasLoadedOnce;

/// Create a copy of LocalDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalDiscoveryStateCopyWith<_LocalDiscoveryState> get copyWith => __$LocalDiscoveryStateCopyWithImpl<_LocalDiscoveryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalDiscoveryState&&const DeepCollectionEquality().equals(other._discoveredServers, _discoveredServers)&&(identical(other.selectedServerId, selectedServerId) || other.selectedServerId == selectedServerId)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasLoadedOnce, hasLoadedOnce) || other.hasLoadedOnce == hasLoadedOnce));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_discoveredServers),selectedServerId,isLoading,hasLoadedOnce);

@override
String toString() {
  return 'LocalDiscoveryState(discoveredServers: $discoveredServers, selectedServerId: $selectedServerId, isLoading: $isLoading, hasLoadedOnce: $hasLoadedOnce)';
}


}

/// @nodoc
abstract mixin class _$LocalDiscoveryStateCopyWith<$Res> implements $LocalDiscoveryStateCopyWith<$Res> {
  factory _$LocalDiscoveryStateCopyWith(_LocalDiscoveryState value, $Res Function(_LocalDiscoveryState) _then) = __$LocalDiscoveryStateCopyWithImpl;
@override @useResult
$Res call({
 List<DiscoveredServer> discoveredServers, String? selectedServerId, bool isLoading, bool hasLoadedOnce
});




}
/// @nodoc
class __$LocalDiscoveryStateCopyWithImpl<$Res>
    implements _$LocalDiscoveryStateCopyWith<$Res> {
  __$LocalDiscoveryStateCopyWithImpl(this._self, this._then);

  final _LocalDiscoveryState _self;
  final $Res Function(_LocalDiscoveryState) _then;

/// Create a copy of LocalDiscoveryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? discoveredServers = null,Object? selectedServerId = freezed,Object? isLoading = null,Object? hasLoadedOnce = null,}) {
  return _then(_LocalDiscoveryState(
discoveredServers: null == discoveredServers ? _self._discoveredServers : discoveredServers // ignore: cast_nullable_to_non_nullable
as List<DiscoveredServer>,selectedServerId: freezed == selectedServerId ? _self.selectedServerId : selectedServerId // ignore: cast_nullable_to_non_nullable
as String?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasLoadedOnce: null == hasLoadedOnce ? _self.hasLoadedOnce : hasLoadedOnce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SelectedServer {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedServer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectedServer()';
}


}

/// @nodoc
class $SelectedServerCopyWith<$Res>  {
$SelectedServerCopyWith(SelectedServer _, $Res Function(SelectedServer) __);
}


/// Adds pattern-matching-related methods to [SelectedServer].
extension SelectedServerPatterns on SelectedServer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Manual value)?  manual,TResult Function( Discovered value)?  discovered,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Manual() when manual != null:
return manual(_that);case Discovered() when discovered != null:
return discovered(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Manual value)  manual,required TResult Function( Discovered value)  discovered,}){
final _that = this;
switch (_that) {
case Manual():
return manual(_that);case Discovered():
return discovered(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Manual value)?  manual,TResult? Function( Discovered value)?  discovered,}){
final _that = this;
switch (_that) {
case Manual() when manual != null:
return manual(_that);case Discovered() when discovered != null:
return discovered(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String address)?  manual,TResult Function( String id)?  discovered,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Manual() when manual != null:
return manual(_that.address);case Discovered() when discovered != null:
return discovered(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String address)  manual,required TResult Function( String id)  discovered,}) {final _that = this;
switch (_that) {
case Manual():
return manual(_that.address);case Discovered():
return discovered(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String address)?  manual,TResult? Function( String id)?  discovered,}) {final _that = this;
switch (_that) {
case Manual() when manual != null:
return manual(_that.address);case Discovered() when discovered != null:
return discovered(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class Manual implements SelectedServer {
  const Manual(this.address);
  

 final  String address;

/// Create a copy of SelectedServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManualCopyWith<Manual> get copyWith => _$ManualCopyWithImpl<Manual>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Manual&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,address);

@override
String toString() {
  return 'SelectedServer.manual(address: $address)';
}


}

/// @nodoc
abstract mixin class $ManualCopyWith<$Res> implements $SelectedServerCopyWith<$Res> {
  factory $ManualCopyWith(Manual value, $Res Function(Manual) _then) = _$ManualCopyWithImpl;
@useResult
$Res call({
 String address
});




}
/// @nodoc
class _$ManualCopyWithImpl<$Res>
    implements $ManualCopyWith<$Res> {
  _$ManualCopyWithImpl(this._self, this._then);

  final Manual _self;
  final $Res Function(Manual) _then;

/// Create a copy of SelectedServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? address = null,}) {
  return _then(Manual(
null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class Discovered implements SelectedServer {
  const Discovered(this.id);
  

 final  String id;

/// Create a copy of SelectedServer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiscoveredCopyWith<Discovered> get copyWith => _$DiscoveredCopyWithImpl<Discovered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Discovered&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'SelectedServer.discovered(id: $id)';
}


}

/// @nodoc
abstract mixin class $DiscoveredCopyWith<$Res> implements $SelectedServerCopyWith<$Res> {
  factory $DiscoveredCopyWith(Discovered value, $Res Function(Discovered) _then) = _$DiscoveredCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$DiscoveredCopyWithImpl<$Res>
    implements $DiscoveredCopyWith<$Res> {
  _$DiscoveredCopyWithImpl(this._self, this._then);

  final Discovered _self;
  final $Res Function(Discovered) _then;

/// Create a copy of SelectedServer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(Discovered(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ServerCompatibilityCheckState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerCompatibilityCheckState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerCompatibilityCheckState()';
}


}

/// @nodoc
class $ServerCompatibilityCheckStateCopyWith<$Res>  {
$ServerCompatibilityCheckStateCopyWith(ServerCompatibilityCheckState _, $Res Function(ServerCompatibilityCheckState) __);
}


/// Adds pattern-matching-related methods to [ServerCompatibilityCheckState].
extension ServerCompatibilityCheckStatePatterns on ServerCompatibilityCheckState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Initial value)?  initial,TResult Function( Load value)?  load,TResult Function( Success value)?  success,TResult Function( Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Load() when load != null:
return load(_that);case Success() when success != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Initial value)  initial,required TResult Function( Load value)  load,required TResult Function( Success value)  success,required TResult Function( Failure value)  failure,}){
final _that = this;
switch (_that) {
case Initial():
return initial(_that);case Load():
return load(_that);case Success():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Initial value)?  initial,TResult? Function( Load value)?  load,TResult? Function( Success value)?  success,TResult? Function( Failure value)?  failure,}){
final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial(_that);case Load() when load != null:
return load(_that);case Success() when success != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  load,TResult Function( ServerCompatibilityCheckResponse response,  SelectedServer server,  Uri uri)?  success,TResult Function( ApiRequestFailure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Load() when load != null:
return load();case Success() when success != null:
return success(_that.response,_that.server,_that.uri);case Failure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  load,required TResult Function( ServerCompatibilityCheckResponse response,  SelectedServer server,  Uri uri)  success,required TResult Function( ApiRequestFailure failure)  failure,}) {final _that = this;
switch (_that) {
case Initial():
return initial();case Load():
return load();case Success():
return success(_that.response,_that.server,_that.uri);case Failure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  load,TResult? Function( ServerCompatibilityCheckResponse response,  SelectedServer server,  Uri uri)?  success,TResult? Function( ApiRequestFailure failure)?  failure,}) {final _that = this;
switch (_that) {
case Initial() when initial != null:
return initial();case Load() when load != null:
return load();case Success() when success != null:
return success(_that.response,_that.server,_that.uri);case Failure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class Initial implements ServerCompatibilityCheckState {
  const Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerCompatibilityCheckState.initial()';
}


}




/// @nodoc


class Load implements ServerCompatibilityCheckState {
  const Load();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerCompatibilityCheckState.load()';
}


}




/// @nodoc


class Success implements ServerCompatibilityCheckState {
  const Success(this.response, this.server, this.uri);
  

 final  ServerCompatibilityCheckResponse response;
 final  SelectedServer server;
 final  Uri uri;

/// Create a copy of ServerCompatibilityCheckState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SuccessCopyWith<Success> get copyWith => _$SuccessCopyWithImpl<Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Success&&(identical(other.response, response) || other.response == response)&&(identical(other.server, server) || other.server == server)&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,response,server,uri);

@override
String toString() {
  return 'ServerCompatibilityCheckState.success(response: $response, server: $server, uri: $uri)';
}


}

/// @nodoc
abstract mixin class $SuccessCopyWith<$Res> implements $ServerCompatibilityCheckStateCopyWith<$Res> {
  factory $SuccessCopyWith(Success value, $Res Function(Success) _then) = _$SuccessCopyWithImpl;
@useResult
$Res call({
 ServerCompatibilityCheckResponse response, SelectedServer server, Uri uri
});


$SelectedServerCopyWith<$Res> get server;

}
/// @nodoc
class _$SuccessCopyWithImpl<$Res>
    implements $SuccessCopyWith<$Res> {
  _$SuccessCopyWithImpl(this._self, this._then);

  final Success _self;
  final $Res Function(Success) _then;

/// Create a copy of ServerCompatibilityCheckState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,Object? server = null,Object? uri = null,}) {
  return _then(Success(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as ServerCompatibilityCheckResponse,null == server ? _self.server : server // ignore: cast_nullable_to_non_nullable
as SelectedServer,null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}

/// Create a copy of ServerCompatibilityCheckState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectedServerCopyWith<$Res> get server {
  
  return $SelectedServerCopyWith<$Res>(_self.server, (value) {
    return _then(_self.copyWith(server: value));
  });
}
}

/// @nodoc


class Failure implements ServerCompatibilityCheckState {
  const Failure(this.failure);
  

 final  ApiRequestFailure failure;

/// Create a copy of ServerCompatibilityCheckState
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
  return 'ServerCompatibilityCheckState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res> implements $ServerCompatibilityCheckStateCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 ApiRequestFailure failure
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of ServerCompatibilityCheckState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(Failure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ApiRequestFailure,
  ));
}


}

/// @nodoc
mixin _$ServerSelectionEffect {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSelectionEffect);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerSelectionEffect()';
}


}

/// @nodoc
class $ServerSelectionEffectCopyWith<$Res>  {
$ServerSelectionEffectCopyWith(ServerSelectionEffect _, $Res Function(ServerSelectionEffect) __);
}


/// Adds pattern-matching-related methods to [ServerSelectionEffect].
extension ServerSelectionEffectPatterns on ServerSelectionEffect {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FocusServerAddress value)?  focusServerAddress,TResult Function( ShowServerSelectionRequired value)?  showServerSelectionRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FocusServerAddress() when focusServerAddress != null:
return focusServerAddress(_that);case ShowServerSelectionRequired() when showServerSelectionRequired != null:
return showServerSelectionRequired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FocusServerAddress value)  focusServerAddress,required TResult Function( ShowServerSelectionRequired value)  showServerSelectionRequired,}){
final _that = this;
switch (_that) {
case FocusServerAddress():
return focusServerAddress(_that);case ShowServerSelectionRequired():
return showServerSelectionRequired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FocusServerAddress value)?  focusServerAddress,TResult? Function( ShowServerSelectionRequired value)?  showServerSelectionRequired,}){
final _that = this;
switch (_that) {
case FocusServerAddress() when focusServerAddress != null:
return focusServerAddress(_that);case ShowServerSelectionRequired() when showServerSelectionRequired != null:
return showServerSelectionRequired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  focusServerAddress,TResult Function()?  showServerSelectionRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FocusServerAddress() when focusServerAddress != null:
return focusServerAddress();case ShowServerSelectionRequired() when showServerSelectionRequired != null:
return showServerSelectionRequired();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  focusServerAddress,required TResult Function()  showServerSelectionRequired,}) {final _that = this;
switch (_that) {
case FocusServerAddress():
return focusServerAddress();case ShowServerSelectionRequired():
return showServerSelectionRequired();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  focusServerAddress,TResult? Function()?  showServerSelectionRequired,}) {final _that = this;
switch (_that) {
case FocusServerAddress() when focusServerAddress != null:
return focusServerAddress();case ShowServerSelectionRequired() when showServerSelectionRequired != null:
return showServerSelectionRequired();case _:
  return null;

}
}

}

/// @nodoc


class FocusServerAddress implements ServerSelectionEffect {
  const FocusServerAddress();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusServerAddress);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerSelectionEffect.focusServerAddress()';
}


}




/// @nodoc


class ShowServerSelectionRequired implements ServerSelectionEffect {
  const ShowServerSelectionRequired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShowServerSelectionRequired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerSelectionEffect.showServerSelectionRequired()';
}


}




// dart format on
