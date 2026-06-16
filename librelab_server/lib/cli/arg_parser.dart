import 'package:args/args.dart';
import 'package:librelab_server/cli/cli_constants.dart';
import 'package:librelab_server/config/server_run_mode.dart';

ArgParser argsParser = ArgParser()
  ..addFlag(
    CliOptions.createSuperUserFlag,
    negatable: false,
    help: 'Prompts to create a new super user',
  )
  ..addFlag(
    CliOptions.applyMigrationsFlag,
    help: 'Applies database migrations (if there are any)',
    defaultsTo: true,
  )
  ..addFlag(
    CliOptions.helpFlag,
    abbr: 'h',
    negatable: false,
    help: 'Displays usage information.',
  )
  ..addOption(
    CliOptions.serverRunModeOption,
    help: 'Sets the server run mode.',
    allowed: ServerRunMode.values.map((e) => e.cliValue),
    allowedHelp: Map.fromEntries(
      ServerRunMode.values.map(
        (e) => MapEntry(e.cliValue, switch (e) {
          ServerRunMode.production => 'Production environment',
          ServerRunMode.development => 'Development environment',
          ServerRunMode.staging => 'Staging environment',
        }),
      ),
    ),
    defaultsTo: ServerRunMode.defaultsTo.cliValue,
  );
