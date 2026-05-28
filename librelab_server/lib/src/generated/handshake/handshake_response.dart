/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../handshake/api_contract_handshake_status.dart' as _i2;

@_i1.immutable
abstract class HandshakeResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  const HandshakeResponse._({
    required this.status,
    required this.serverBuildNumber,
    required this.serverVersion,
  });

  const factory HandshakeResponse({
    required _i2.ApiContractHandshakeStatus status,
    required int serverBuildNumber,
    required String serverVersion,
  }) = _HandshakeResponseImpl;

  factory HandshakeResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return HandshakeResponse(
      status: _i2.ApiContractHandshakeStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      serverBuildNumber: jsonSerialization['serverBuildNumber'] as int,
      serverVersion: jsonSerialization['serverVersion'] as String,
    );
  }

  final _i2.ApiContractHandshakeStatus status;

  final int serverBuildNumber;

  final String serverVersion;

  /// Returns a shallow copy of this [HandshakeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HandshakeResponse copyWith({
    _i2.ApiContractHandshakeStatus? status,
    int? serverBuildNumber,
    String? serverVersion,
  });
  @override
  bool operator ==(Object other) {
    return identical(
          other,
          this,
        ) ||
        other.runtimeType == runtimeType &&
            other is HandshakeResponse &&
            (identical(
                  other.status,
                  status,
                ) ||
                other.status == status) &&
            (identical(
                  other.serverBuildNumber,
                  serverBuildNumber,
                ) ||
                other.serverBuildNumber == serverBuildNumber) &&
            (identical(
                  other.serverVersion,
                  serverVersion,
                ) ||
                other.serverVersion == serverVersion);
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      status,
      serverBuildNumber,
      serverVersion,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HandshakeResponse',
      'status': status.toJson(),
      'serverBuildNumber': serverBuildNumber,
      'serverVersion': serverVersion,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HandshakeResponse',
      'status': status.toJson(),
      'serverBuildNumber': serverBuildNumber,
      'serverVersion': serverVersion,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HandshakeResponseImpl extends HandshakeResponse {
  const _HandshakeResponseImpl({
    required _i2.ApiContractHandshakeStatus status,
    required int serverBuildNumber,
    required String serverVersion,
  }) : super._(
         status: status,
         serverBuildNumber: serverBuildNumber,
         serverVersion: serverVersion,
       );

  /// Returns a shallow copy of this [HandshakeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HandshakeResponse copyWith({
    _i2.ApiContractHandshakeStatus? status,
    int? serverBuildNumber,
    String? serverVersion,
  }) {
    return HandshakeResponse(
      status: status ?? this.status,
      serverBuildNumber: serverBuildNumber ?? this.serverBuildNumber,
      serverVersion: serverVersion ?? this.serverVersion,
    );
  }
}
