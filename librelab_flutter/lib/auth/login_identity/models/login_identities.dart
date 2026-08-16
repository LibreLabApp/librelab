// ignore_for_file: annotate_overrides

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:librelab_flutter/auth/login_identity/models/login_identity.dart';
import 'package:librelab_flutter/common/json_types.dart' show JsonMap;
import 'package:librelab_flutter/user/models/server.dart';

part 'login_identities.freezed.dart';
part 'login_identities.g.dart';

/// Locally configured login identities and their associated servers.
///
/// Represents the users added to this app installation for local use,
/// independent of users managed on a server.
@immutable
@Freezed(fromJson: false, toJson: false)
@JsonSerializable()
class const LoginIdentities({
  /// The [LoginIdentity.id] of the selected [LoginIdentity].
  /// `null` if none has been selected.
  required final int? selectedLoginIdentityId,

  /// Servers configured for the local users.
  ///
  /// Multiple [LoginIdentity]s can reference the same server.
  required final List<Server> servers,

  /// Login identities configured in this app installation.
  required final List<LoginIdentity> loginIdentities,
}) with _$LoginIdentities {
  factory fromJson(JsonMap json) => _$LoginIdentitiesFromJson(json);
  JsonMap toJson() => _$LoginIdentitiesToJson(this);
}
