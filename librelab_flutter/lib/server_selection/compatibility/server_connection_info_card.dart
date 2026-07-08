import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:librelab_flutter/common/ui/widgets/alert_card.dart';
import 'package:librelab_flutter/generated/i18n/strings.g.dart';
import 'package:librelab_shared/librelab_shared.dart';

enum ConnectionNoticeType { http, ipAddress, httpAndIpAddress }

class const ServerConnectionInfoCard({
  super.key,
  required final ConnectionNoticeType type,
  required final Uri uri,
}) extends StatelessWidget {
  static bool _isHttp(Uri uri) {
    if (kIsWeb) {
      // On web, an empty base URL resolves requests against the browser origin.
      // Therefore, the browser origin scheme determines the actual request scheme.
      final usesCurrentBrowserOrigin = uri.scheme.isEmpty;
      final browserOrigin = Uri.base;

      if (usesCurrentBrowserOrigin && browserOrigin.isHttp) {
        return true;
      }
    }
    return uri.isHttp;
  }

  static ConnectionNoticeType? getNoticeType(Uri uri) {
    // TODO: Implement isIpAddress on the web
    // ignore: avoid_bool_literals_in_conditional_expressions
    final isIpAddress = kIsWeb ? false : uri.isIpAddress;
    final isHttp = _isHttp(uri);

    if (isHttp && isIpAddress) {
      return .httpAndIpAddress;
    }
    if (isHttp) {
      return .http;
    }
    if (isIpAddress) {
      return .ipAddress;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.serverCompatibility.check.success.connectionInfo;
    final (String title, String subtitle) = switch (type) {
      .http => (t.http.title, t.http.subtitle),
      .ipAddress => (t.ipAddress.title, t.ipAddress.subtitle),
      .httpAndIpAddress => (
        t.httpAndIpAddress.title,
        t.httpAndIpAddress.subtitle,
      ),
    };

    return AlertCard(
      type: .warning,
      title: Text(title),
      subtitle: Text(subtitle),
      prefixIcon: null,
      suffix: null,
    );
  }
}
