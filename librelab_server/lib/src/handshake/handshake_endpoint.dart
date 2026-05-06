import 'dart:async';

import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class HandshakeEndpoint extends Endpoint {
  static const _minClientBuild = 1;

  Future<HandshakeResponse> check(
    Session session,
    HandshakeRequest request,
  ) async => HandshakeResponse(
    status: request.clientBuildNumber < _minClientBuild
        ? HandshakeStatus.updateClient
        : HandshakeStatus.ok,
    serverBuildNumber: Pubspec.versionBuildNumber,
    serverVersion: Pubspec.version,
  );
}
