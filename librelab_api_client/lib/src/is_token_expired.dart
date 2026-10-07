import 'package:clock/clock.dart' show clock;

/// Returns the current time in UTC.
DateTime _timeNowUTC() {
  return clock.now().toUtc();
}

/// Returns whether [expiresAt] has expired or is within [buffer] of expiring.
///
/// [expiresAt] must be a UTC [DateTime].
///
/// The [buffer] accounts for tokens that may expire while a request is in
/// flight, such as due to network latency or server-side processing time.
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
