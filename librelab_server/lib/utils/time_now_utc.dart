import 'package:clock/clock.dart' show clock;

/// Returns the current time in UTC.
DateTime timeNowUTC() {
  return clock.now().toUtc();
}
