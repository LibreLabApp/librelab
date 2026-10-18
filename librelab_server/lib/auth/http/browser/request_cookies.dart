import 'dart:io' show HttpHeaders;

import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';

@immutable
class const CookieValue(final String name, final String value);

extension RequestCookies on Request {
  /// Returns the valid cookies found in [HttpHeaders.cookieHeader].
  Iterable<CookieValue> get cookies sync* {
    final header = headers[HttpHeaders.cookieHeader];
    if (header == null || header.isEmpty) {
      return;
    }

    try {
      for (final part in header.split(';')) {
        final separator = part.indexOf('=');
        if (separator <= 0) {
          continue;
        }

        yield CookieValue(
          part.substring(0, separator).trim(),
          part.substring(separator + 1).trim(),
        );
      }
    } on Exception catch (_) {
      // Ignore malformed cookies.
    }
  }
}

extension CookieValuesListExt on Iterable<CookieValue> {
  String? valueOf(String cookieName) {
    return toList().firstWhereOrNull((e) => e.name == cookieName)?.value;
  }
}
