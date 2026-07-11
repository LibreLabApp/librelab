import 'dart:io' as io show InternetAddress;

const String _https = 'https';
const String _http = 'http';

extension UriExt on Uri {
  bool get isHttps => isScheme(_https);
  bool get isHttp => isScheme(_http);

  Uri withHttps() => replace(scheme: _https);
  Uri withHttp() => replace(scheme: _http);

  /// Unsupported on the web
  bool get isIpAddress {
    return io.InternetAddress.tryParse(host) != null;
  }
}
