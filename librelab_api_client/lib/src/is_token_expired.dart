import 'package:clock/clock.dart' show clock;

/// Returns the current time in UTC.
DateTime _timeNowUTC() {
  return clock.now().toUtc();
}

/// Includes an optional [buffer] to catch tokens about to expire (in flight).
bool isTokenExpired(
  DateTime expiresAt, {
  Duration buffer = const Duration(seconds: 10),
}) {
  final now = _timeNowUTC();
  if (!expiresAt.isUtc) {
    throw ArgumentError(
      'expiresAt must be in UTC. Received: $expiresAt '
      '(isUtc: ${expiresAt.isUtc}).',
    );
  }

  return now.add(buffer).isAfter(expiresAt);
}
