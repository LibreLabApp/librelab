import 'package:logging/logging.dart';

void setupLogger(
  void Function(String message, {required bool hasError}) onLog,
) {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: ${record.message}';

    final error = record.error;
    final stacktrace = record.stackTrace;

    final messageWithDetails = StringBuffer('$message\n')
      ..writeAll([
        if (error != null) '  Error: $error\n',
        if (stacktrace != null) '  StackTrace: $stacktrace\n',
      ]);

    onLog(messageWithDetails.toString(), hasError: error != null);
  });
}
