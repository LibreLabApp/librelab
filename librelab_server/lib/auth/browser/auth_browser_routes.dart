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
import 'package:librelab_shared/librelab_shared.dart';
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
    required Future<String> Function() readRefreshToken,
    required Map<String, Object> Function()? successHeaders,
  })
  _logout,
  required final Future<Response> Function(
    Request request, {
    required Future<String> Function() readRefreshToken,
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

        return response.toJson().httpResponse(
          .ok,
          headers: {
            HttpHeaders.setCookieHeader: <String>[
              _accessTokenCookie(
                .set(accessToken.token, accessToken.expiresAt),
              ).toString(),
              _refreshTokenCookie(
                .set(refreshToken.token, refreshToken.expiresAt),
              ).toString(),
            ],
          },
        );
      },
    );
  }

  String? _refreshTokenFromCookies(Iterable<CookieValue> cookies) {
    return cookies.valueOf(AuthCookieNames.refreshToken);
  }

  Future<Response> logoutHandler(Request request) async {
    final headers = {
      HttpHeaders.setCookieHeader: <String>[
        _accessTokenCookie(const .remove()).toString(),
        _refreshTokenCookie(const .remove()).toString(),
      ],
    };

    final cookies = request.cookies;
    final refreshToken = _refreshTokenFromCookies(cookies);

    if (refreshToken == null) {
      return const LogoutResponse(
        tokenRevoked: false,
      ).toJson().httpResponse(.ok, headers: headers);
    }

    return _logout(
      request,
      readRefreshToken: () async => refreshToken,
      successHeaders: () => headers,
    );
  }

  Future<Response> refreshHandler(Request request) async {
    final cookies = request.cookies;
    final refreshToken = _refreshTokenFromCookies(cookies);
    if (refreshToken == null) {
      return const ServerErrorResponse(
        code: AuthErrorCodes.reAuthenticationRequired,
        message:
            'The refresh token cookie was not found. It may have been expired.',
        details: {AuthErrorDetailsKeys.reason: 'REFRESH_TOKEN_COOKIE_MISSING'},
      ).toJson().httpResponse(.unauthorized);
    }

    return _refresh(
      request,
      readRefreshToken: () async => refreshToken,
      success: (tokens) {
        final (accessToken, refreshToken) = (
          tokens.accessToken,
          tokens.refreshTokenRaw,
        );

        return emptyJson.httpResponse(
          HttpStatusCode.ok,
          headers: {
            HttpHeaders.setCookieHeader: <String>[
              _accessTokenCookie(
                .set(accessToken.token, accessToken.expiresAt),
              ).toString(),
              _refreshTokenCookie(
                .set(refreshToken.token, refreshToken.expiresAt),
              ).toString(),
            ],
          },
        );
      },
    );
  }

  /// Returns API root path, guaranteed to start with `/` and not end with `/`.
  String get _apiPath {
    const apiPath = ApiDeployment.rootPath;
    if (!apiPath.startsWith('/') || apiPath.endsWith('/')) {
      throw ArgumentError.value(
        apiPath,
        'apiPath',
        'must start with "/" and must not end with "/"',
      );
    }
    return apiPath;
  }

  Cookie _createCookie({
    required String name,
    required String value,
    required String path,
    required DateTime expires,
    required int maxAge,
  }) => Cookie(name, value)
    ..httpOnly = true
    ..secure = _cookiesRequireSecureConnection
    ..sameSite = .strict
    ..path = path
    ..expires = expires
    ..maxAge = maxAge;

  Cookie _accessTokenCookie(CookieOperation operation) {
    final (String value, DateTime expires, int maxAge) = operation
        .cookieParameters();

    return _createCookie(
      name: AuthCookieNames.accessToken,
      value: value,
      path: '$_apiPath/',
      expires: expires,
      maxAge: maxAge,
    );
  }

  Cookie _refreshTokenCookie(CookieOperation operation) {
    final (String value, DateTime expires, int maxAge) = operation
        .cookieParameters();

    return _createCookie(
      name: AuthCookieNames.refreshToken,
      value: value,
      path: () {
        final apiPath = _apiPath;

        // Due to the limitation of the current ApiEndpointDefinitions
        // code generator, which does not expose API group paths,
        // this API group path is hardcoded.

        // This statement was added so that if the path below is changed,
        // it will cause a compilation error here, with the hope that the
        // maintainer will update the path below as well.
        // ignore: unnecessary_statements
        ApiEndpointDefinitions.auth_browser_refresh$POST.path;
        const authPath = 'auth/browser/';

        return '$apiPath/$authPath';
      }(),
      expires: expires,
      maxAge: maxAge,
    );
  }
}
