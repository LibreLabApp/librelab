import 'package:librelab_server/utils/time_now_utc.dart';
import 'package:meta/meta.dart';

@immutable
sealed class const CookieOperation() {
  const factory set(String value, DateTime expiresAt) = SetCookieOperation;
  const factory remove() = RemoveCookieOperation;

  (String value, DateTime expires, int maxAge) cookieParameters() {
    return switch (this) {
      SetCookieOperation(:final value, :final expiresAt) => (
        value,
        expiresAt,
        _maxAge(expiresAt),
      ),
      RemoveCookieOperation() => (
        '',
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        // maxAge must be 0 when deleting the cookie.
        0,
      ),
    };
  }
}

final class const SetCookieOperation(
  final String value,
  final DateTime expiresAt,
) extends CookieOperation;

final class const RemoveCookieOperation() extends CookieOperation;

int _maxAge(DateTime expiresAt) => expiresAt.difference(timeNowUTC()).inSeconds;
