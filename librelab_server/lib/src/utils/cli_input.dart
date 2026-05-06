import 'dart:io';

String promptInput(
  String prompt, {
  bool allowEmpty = false,
  String? Function(String input)? validateInput,
}) {
  while (true) {
    stdout.write('$prompt: ');
    final input = stdin.readLineSync();

    final value = input?.trim() ?? '';

    if (value.isEmpty) {
      if (allowEmpty) {
        return value;
      }

      stderr.writeln('Input required. Please enter a value.');
      continue;
    }

    final error = validateInput?.call(value);
    if (error != null) {
      stderr.writeln(error);
      continue;
    }

    return value;
  }
}

bool promptYesNo(String prompt, {bool? defaultValue}) {
  final defaultHint = defaultValue == null
      ? 'y/n'
      : (defaultValue ? 'Y/n' : 'y/N');

  while (true) {
    stdout.write('$prompt [$defaultHint]: ');
    final input = stdin.readLineSync()?.trim().toLowerCase();

    if (input == null || input.isEmpty) {
      if (defaultValue != null) {
        return defaultValue;
      }
      stderr.writeln('Input required. Please enter yes or no.');
      continue;
    }

    if (input == 'y' || input == 'yes') {
      return true;
    }
    if (input == 'n' || input == 'no') {
      return false;
    }

    stderr.writeln('Invalid input. Please enter yes or no.');
  }
}
