// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_identities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginIdentities _$LoginIdentitiesFromJson(Map<String, dynamic> json) =>
    LoginIdentities(
      selectedLoginIdentityId: (json['selectedLoginIdentityId'] as num?)
          ?.toInt(),
      servers: (json['servers'] as List<dynamic>)
          .map((e) => Server.fromJson(e as Map<String, dynamic>))
          .toList(),
      loginIdentities: (json['loginIdentities'] as List<dynamic>)
          .map((e) => LoginIdentity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginIdentitiesToJson(LoginIdentities instance) =>
    <String, dynamic>{
      'selectedLoginIdentityId': instance.selectedLoginIdentityId,
      'servers': instance.servers,
      'loginIdentities': instance.loginIdentities,
    };
