import 'dart:io';

import 'package:librelab_api_contract/api_endpoint_definition.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/auth/auth_service/auth_service.dart';
import 'package:librelab_server/auth/browser/auth_cookie_names.dart';
import 'package:librelab_server/auth/browser/cookie_operation.dart';
import 'package:librelab_server/auth/browser/request_cookies.dart';
import 'package:librelab_server/server/json_http_extensions.dart';
import 'package:librelab_server/user/mapper.dart';
import 'package:librelab_server/utils/http_status_code.dart';
import 'package:shelf/shelf.dart';

class AuthBrowserRoutes({
  required final bool _cookiesRequireSecureConnection,
  required final Future<Response> Function(
    Request request, {
    required Response Function(AuthenticatedSession session) success,
  })
  _login,
  required final Future<Response> Function(
    Request request, {
    required Future<String?> Function() readRefreshToken,
    required Map<String, Object> Function()? successHeaders,
  })
  _logout,
  required final Future<Response> Function(
    Request request, {
    required Future<String?> Function() readRefreshToken,
    required Response Function(AuthTokens tokens) success,
  })
  _refresh,
}) {
  Future<Response> loginHandler(Request request) async {
    return _login(
      request,
      success: (session) {
        final (user, tokens) = session;
        final response = LoginBrowserResponse(user: user.toResponse());

        final (accessToken, refreshToken) = (
          tokens.accessToken,
          tokens.refreshTokenRaw,
        );

        if (!accessToken.expiresAt.isUtc || !refreshToken.expiresAt.isUtc) {
          return const ServerErrorResponse(
            message: 'Internal bug: Token expiration times must be in UTC.',
            code: 'INTERNAL_BUG',
          ).toJson().httpResponse(.internalServerError);
        }

        final accessCookie = _accessTokenCookie(
          .set(accessToken.token, accessToken.expiresAt),
        );

        final refreshCookie = _refreshTokenCookie(
          .set(refreshToken.token, refreshToken.expiresAt),
        );

        return response.toJson().httpResponse(
          .ok,
          headers: {
            HttpHeaders.setCookieHeader: <String>[
              accessCookie.toString(),
              refreshCookie.toString(),
            ],
          },
        );
      },
    );
  }

  String? _refreshTokenFromCookies(Iterable<CookieValue> cookies) {
    return cookies.valueOf(AuthCookieNames.refreshToken);
  }

  Future<Response> logoutHandler(Request request) {
    return _logout(
      request,
      readRefreshToken: () async {
        final cookies = request.cookies;
        return _refreshTokenFromCookies(cookies);
      },
      successHeaders: () {
        final accessCookie = _accessTokenCookie(const .remove());
        final refreshCookie = _refreshTokenCookie(const .remove());
        return {
          HttpHeaders.setCookieHeader: <String>[
            accessCookie.toString(),
            refreshCookie.toString(),
          ],
        };
      },
    );
  }

  Future<Response> refreshHandler(Request request) async {
    return _refresh(
      request,
      readRefreshToken: () async {
        final cookies = request.cookies;
        return _refreshTokenFromCookies(cookies);
      },
      success: (tokens) {
        final (accessToken, refreshToken) = (
          tokens.accessToken,
          tokens.refreshTokenRaw,
        );

        final accessCookie = _accessTokenCookie(
          .set(accessToken.token, accessToken.expiresAt),
        );

        final refreshCookie = _refreshTokenCookie(
          .set(refreshToken.token, refreshToken.expiresAt),
        );
        return Response(
          HttpStatusCode.noContent.value,
          body: null,
          headers: {
            HttpHeaders.setCookieHeader: <String>[
              accessCookie.toString(),
              refreshCookie.toString(),
            ],
          },
        );
      },
    );
  }

  Cookie _accessTokenCookie(CookieOperation operation) {
    final (String value, DateTime expires, int maxAge) = operation
        .cookieParameters();

    return Cookie(AuthCookieNames.accessToken, value)
      ..httpOnly = true
      ..secure = _cookiesRequireSecureConnection
      ..sameSite = .strict
      ..path = '/'
      ..expires = expires
      ..maxAge = maxAge;
  }

  Cookie _refreshTokenCookie(CookieOperation operation) {
    final (String value, DateTime expires, int maxAge) = operation
        .cookieParameters();

    return Cookie(AuthCookieNames.refreshToken, value)
      ..httpOnly = true
      ..secure = _cookiesRequireSecureConnection
      ..sameSite = .strict
      ..path = () {
        // Due to the limitation of the current ApiEndpointDefinitions
        // code generator, which does not expose API group paths,
        // this API group path is hardcoded.

        // This statement was added so that if the path below is changed,
        // it will cause a compilation error here, with the hope that the
        // maintainer will update the path below as well.
        // ignore: unnecessary_statements
        ApiEndpointDefinitions.auth_browser_refresh$POST.path;
        return '/auth/browser';
      }()
      ..expires = expires
      ..maxAge = maxAge;
  }
}
