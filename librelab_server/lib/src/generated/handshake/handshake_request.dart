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

abstract class HandshakeRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  HandshakeRequest._({required this.clientBuildNumber});

  factory HandshakeRequest({required int clientBuildNumber}) =
      _HandshakeRequestImpl;

  factory HandshakeRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return HandshakeRequest(
      clientBuildNumber: jsonSerialization['clientBuildNumber'] as int,
    );
  }

  int clientBuildNumber;

  /// Returns a shallow copy of this [HandshakeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  HandshakeRequest copyWith({int? clientBuildNumber});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HandshakeRequest',
      'clientBuildNumber': clientBuildNumber,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HandshakeRequest',
      'clientBuildNumber': clientBuildNumber,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _HandshakeRequestImpl extends HandshakeRequest {
  _HandshakeRequestImpl({required int clientBuildNumber})
    : super._(clientBuildNumber: clientBuildNumber);

  /// Returns a shallow copy of this [HandshakeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  HandshakeRequest copyWith({int? clientBuildNumber}) {
    return HandshakeRequest(
      clientBuildNumber: clientBuildNumber ?? this.clientBuildNumber,
    );
  }
}
