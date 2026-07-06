import 'dart:io' show HttpHeaders, Platform;

import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:librelab_flutter/common/platform/platform_check.dart';
import 'package:librelab_flutter/generated/pubspec.g.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:ok_http/ok_http.dart';
import 'package:win_http/win_http.dart';

Client createHttpClient() {
  return _UserAgentClient(
    _createPlatformClient(),
    userAgent: _buildUserAgent(),
  );
}

String _buildUserAgent() {
  return '${ProjectConstants.userAgentAppName}/${Pubspec.fullVersion} (${Platform.operatingSystem}; ${Platform.operatingSystemVersion}; +${ProjectConstants.website})';
}

BaseClient _createPlatformClient() {
  if (isAndroid) {
    return OkHttpClient();
  }
  if (isWindows) {
    return WinHttpClient.defaultConfiguration();
  }
  if (isDarwin) {
    return CupertinoClient.defaultSessionConfiguration();
  }
  return IOClient();
}

/// Only used on IO platforms. Browsers set the `User-Agent` header automatically.
class _UserAgentClient(final Client _inner, {required final String userAgent})
    extends BaseClient {
  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers[HttpHeaders.userAgentHeader] = userAgent;
    return _inner.send(request);
  }

  @override
  void close() => _inner.close();
}
