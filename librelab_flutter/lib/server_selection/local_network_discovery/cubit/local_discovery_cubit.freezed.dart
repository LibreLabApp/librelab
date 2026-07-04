// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_discovery_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalDiscoveryState {

 List<DiscoveredServer> get discoveredServers; String? get selectedServerId; bool get isLoading; bool get hasLoadedOnce;
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

// dart format on
