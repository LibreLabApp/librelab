import 'dart:io' as io show InternetAddress;

extension UriExt on Uri {
  bool get isHttps => isScheme('https');
  bool get isHttp => isScheme('http');

  /// Unsupported on the web
  bool get isIpAddress {
    return io.InternetAddress.tryParse(host) != null;
  }
}
