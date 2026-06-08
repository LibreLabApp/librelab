import 'dart:io';

import 'package:args/args.dart';
import 'package:librelab_api_contract/librelab_api_contract.dart';
import 'package:librelab_server/app_files.dart';
import 'package:librelab_server/auth/ensure_has_admin_user.dart';
import 'package:librelab_server/config/config.dart';
import 'package:librelab_server/constants/constants.dart';
import 'package:librelab_server/database/database_client.dart';
import 'package:librelab_server/database/database_migration_runner.dart';
import 'package:librelab_server/database/database_migrations.g.dart';
import 'package:librelab_server/database/postgres_installer/postgres_installer.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/handshake/handshake_route.dart';
import 'package:librelab_server/mdns/mdns.dart';
import 'package:librelab_server/utils/file_storage/yaml_file_storage.dart';
import 'package:librelab_server/utils/is_debug_mode.dart';
import 'package:librelab_server/utils/json_http_extensions.dart';
import 'package:librelab_server/utils/platform_check.dart';
import 'package:librelab_server/utils/server_port_availability.dart';
import 'package:librelab_server/utils/shutdown/shutdown.dart';
import 'package:librelab_server/utils/shutdown/shutdown_hook_registry.dart';
import 'package:librelab_server/utils/utils.dart';
import 'package:librelab_shared/librelab_shared.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

ArgParser _argsParser = ArgParser()
  ..addFlag(
    CliOptions.forceCreateAdminFlag,
    negatable: false,
    help:
        'Forces the server to prompt to create a new admin user even if '
        'the first admin user was already created before.',
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

enum ServerRunMode {
  production(cliValue: 'production'),
  development(cliValue: 'development'),
  staging(cliValue: 'staging');

  const ServerRunMode({required this.cliValue});

  // Use this instead of .name to prevent unintended breaking changes when renaming
  final String cliValue;

  static ServerRunMode fromCliValue(String? value) {
    if (value == ServerRunMode.development.cliValue) {
      return .development;
    }
    if (value == ServerRunMode.production.cliValue) {
      return .production;
    }
    if (value == ServerRunMode.staging.cliValue) {
      return .staging;
    }
    throw ArgumentError.value(
      value,
      'value',
      'unknown server run mode. allowed values: $values',
    );
  }

  static ServerRunMode get defaultsTo {
    return kDebugMode ? ServerRunMode.development : ServerRunMode.production;
  }
}

final _logger = Logger('Main');

Future<void> run(List<String> args) async {
  stdout.writeln(
    'Server version: ${Pubspec.version}\n'
    'Arguments: $args\n'
    'Current directory: ${Directory.current.absolute.path}\n'
    'Operating system: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
  );

  final parser = _argsParser;
  final argResults = parser.parse(args);

  final serverRunMode = ServerRunMode.fromCliValue(
    argResults.option(CliOptions.serverRunModeOption),
  );

  stdout.writeln('Run mode: ${serverRunMode.name}\n');

  _setupLogger();

  final shutdownHookRegistry = ShutdownHookRegistry();
  final shutdown = Shutdown(hookRegistry: shutdownHookRegistry);

  await _registerProcessShutdownSignalHandlers(shutdown);

  if (argResults.wasParsed(CliOptions.helpFlag)) {
    stderr.writeln(parser.usage);
    await shutdown(isSuccess: true);
  }

  final forceCreateAdminUser = argResults.wasParsed(
    CliOptions.forceCreateAdminFlag,
  );
  final autoApplyMigrations = argResults.flag(CliOptions.applyMigrationsFlag);

  final workingDirectory = kDebugMode ? Directory('data') : null;
  if (workingDirectory != null && !workingDirectory.existsSync()) {
    await workingDirectory.create();
  }
  final appFiles = AppFiles(workingDirectory: workingDirectory);

  final configRepository = AppConfigRepository(
    file: appFiles.config,
    fileStorage: YamlFileStorage(),
  );

  final config = await _loadAppConfig(
    configRepository,
    getConfigFilePath: () => appFiles.config.path,
    shutdown: shutdown,
  );

  final databaseConfig = config.database;
  final isLocalHostDatabase = isLocalHost(databaseConfig.host);

  final mdnsConfig = configRepository.configOrThrow.mdnsServicePublish;

  final secretsRepository = AppSecretsRepository(
    file: appFiles.secrets,
    fileStorage: YamlFileStorage(),
    platformEnvironment: Platform.environment,
  );

  final secrets = await _loadAppSecrets(
    secretsRepository,
    isLocalHostDatabase: isLocalHostDatabase,
    getConfigFilePath: () => appFiles.config.path,
    getSecretsFilePath: () => appFiles.secrets.path,
  );

  await _maybeInstallSystemMdns(
    getConfigFilePath: () => appFiles.config.path,
    setupPromptDeclinedConfig: config.setupPromptDeclined,
    config: mdnsConfig,
    appConfigRepository: configRepository,
    shutdown: shutdown,
  );

  final shouldShowPostgresInstallPrompt =
      !config.setupPromptDeclined.postgres && isLocalHostDatabase;

  if (shouldShowPostgresInstallPrompt) {
    await tryInstallPostgresWithPrompt(
      appUser: databaseConfig.user,
      appPassword: secrets.databasePassword,
      appDatabaseName: databaseConfig.name,
      onDeclined: () => configRepository.update(
        setupPromptDeclined: config.setupPromptDeclined.copyWith(
          postgres: true,
        ),
      ),
      getConfigFilePath: () => appFiles.config.path,
      shutdown: shutdown,
    );
  }

  // TODO: (REMOVE_SERVERPOD) Handle connection issues and other failures
  //  handle SocketException, Exception, PgException/ServerException (e.g., invalid password, database, user)
  final databaseClient = await DatabaseClient.connect(
    host: databaseConfig.host,
    port: databaseConfig.port,
    database: databaseConfig.name,
    username: databaseConfig.user,
    password: secrets.databasePassword,
    // TODO: (REMOVE_SERVERPOD) Respect user config
    sslMode: .disable,
  );
  shutdownHookRegistry.register('closeDatabaseConnection', () async {
    stderr.writeln('Shutting down the database connection...');
    await databaseClient.close();
  });

  if (autoApplyMigrations) {
    final migrationRunner = DatabaseMigrationRunner(
      client: databaseClient,
      migrations: DatabaseMigrations.list,
      logger: Logger('DatabaseMigrationRunner'),
    );
    await migrationRunner.run();
  }

  final apiServerPort = config.apiServer.listen.port;
  final apiServerAddress = config.apiServer.listen.address;

  await enforcePortAvailability(
    port: apiServerPort,
    getConfigFilePath: () => appFiles.config.path,
    shutdown: shutdown,
  );

  final server = await _startServer(
    port: apiServerPort,
    address: apiServerAddress,
  );

  shutdownHookRegistry.register('closingHttpServer', () async {
    stderr.writeln('Shutting down the HTTP server...');
    await server.close();
  });

  if (!forceCreateAdminUser && mdnsConfig.enabled) {
    await _registerMdnsService(
      serverPort: apiServerPort,
      shutdownHookRegistry: shutdownHookRegistry,
      instanceName: mdnsConfig.instanceName,
    );
  }

  await _initializeAdminUser(
    forceCreateAdminUser: forceCreateAdminUser,
    shutdown: shutdown,
  );
}

void _setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final level = record.level;
    final message = '${record.level.name}: ${record.time}: ${record.message}';

    final errorLevels = {Level.WARNING, Level.SEVERE, Level.SHOUT};
    if (errorLevels.contains(level)) {
      stderr.writeln(
        '$message\n'
        '  Error: ${record.error}\n'
        '  StackTrace: ${record.stackTrace}\n',
      );
    } else {
      stdout.writeln(message);
    }
  });
}

Future<HttpServer> _startServer({
  required int port,
  required String address,
}) async {
  final app = Router(
    notFoundHandler: (request) => ServerErrorResponse(
      message: 'Route not found',
      code: 'NOT_FOUND',
      details: {
        'url': request.url.toString(),
        'requestUri': request.requestedUri.toString(),
        'method': request.method,
      },
    ).toJson().httpResponse(.notFound),
  );

  app.get('/', (Request request) {
    return Response.ok('OK');
  });
  app.mount('/', HandshakeRoute().router.call);

  final handler = const Pipeline()
      .addMiddleware(withErrorHandling)
      .addHandler(app.call);

  final server = await shelf_io.serve(handler, address, port);
  server.autoCompress = true;

  return server;
}

Handler withErrorHandling(Handler innerHandler) {
  return (Request request) async {
    try {
      return await innerHandler(request);
    } on InvalidJsonRequestBodyException catch (e) {
      return _mapException(e);
    } on InvalidJsonRequestBodySchemaException catch (e) {
      return _mapException(e);
    } on Exception catch (e, stackTrace) {
      _logUnhandled(e, stackTrace);
      return _mapException(e);
    }
  };
}

void _logUnhandled(Object e, StackTrace stackTrace) {
  _logger.severe('Unhandled exception in request handler', e, stackTrace);
}

Response _mapException(Exception e) {
  final (errorResponse, statusCode) = switch (e) {
    InvalidJsonRequestBodyException() => (
      const ServerErrorResponse(
        code: 'MALFORMED_JSON',
        message: 'Malformed or unparsable JSON payload.',
      ),
      HttpStatusCode.badRequest,
    ),
    InvalidJsonRequestBodySchemaException() => (
      const ServerErrorResponse(
        code: 'JSON_SCHEMA_MISMATCH',
        message: 'Payload schema mismatch. A client update may be required.',
      ),
      HttpStatusCode.badRequest,
    ),
    Exception() => (
      const ServerErrorResponse(
        message: 'INTERNAL_SERVER_ERROR',
        code: 'Unhandled server error',
      ),
      HttpStatusCode.internalServerError,
    ),
  };

  return errorResponse.toJson().httpResponse(statusCode);
}

Future<void> _initializeAdminUser({
  required bool forceCreateAdminUser,
  required Shutdown shutdown,
}) async {
  if (forceCreateAdminUser) {
    await createAdminUser();
    await shutdown(isSuccess: true);
  } else {
    await ensureHasAdminUser();
  }
}

Future<AppConfig> _loadAppConfig(
  AppConfigRepository repository, {
  required String Function() getConfigFilePath,
  required Shutdown shutdown,
}) async {
  final appConfig = await repository.load();
  if (appConfig == null) {
    final apiPort = await findAvailablePortOrShutdown(
      preferredPort: ProjectConstants.defaultApiPort,
      shutdown: shutdown,
    );
    final defaultConfig = AppConfig.defaultConfig(
      mdnsServicePublish: promptMdnsServicePublishConfig(),
      port: apiPort,
    );
    await repository.save(defaultConfig);

    stdout.writeln(
      'Created "${getConfigFilePath()}" with default config (API server port: $apiPort).\n'
      'Important: If you are deploying to the cloud, please read the following cloud deployment notes!\n'
      'For local networks, the default is sufficient.\n\n'
      'Cloud deployment notes (not required for local networks):'
      '\n'
      '1. Use a reverse proxy/load balancer for HTTPS (e.g., Nginx)\n'
      '2. Update host, port, and scheme for API and database\n'
      '3. Update address from 0.0.0.0 to 127.0.0.1\n\n'
      'Note: PostgreSQL install prompt is disabled for remote databases (non-localhost hosts)',
    );

    return defaultConfig;
  }
  return appConfig;
}

Future<AppSecrets> _loadAppSecrets(
  AppSecretsRepository repository, {
  required String Function() getSecretsFilePath,
  required String Function() getConfigFilePath,
  required bool isLocalHostDatabase,
}) async {
  final appSecrets = await repository.load();

  try {
    if (appSecrets == null) {
      final defaultSecrets = AppSecrets(
        databasePassword: generateSecureRandomString(),
      );

      final secretsFilePath = getSecretsFilePath();
      final configFilePath = getConfigFilePath();

      stdout.writeln(
        'Created "$secretsFilePath" with randomly generated secrets.\n'
        'This file should not be under version control. It must remain in a safe place\n\n'
        'SECURITY: Prefer providing secrets via environment variables,\n'
        'especially in cloud deployments.\n'
        'Use this format: "${AppSecretsRepository.envSecretKeyPrefix}*",\n'
        'e.g., ${AppSecretsRepository.envSecretKeyPrefix}${AppSecrets.databasePasswordKey}=... \n\n'
        'Environment variables override values in the config file ("$secretsFilePath").\n',
      );

      if (!isLocalHostDatabase) {
        stdout.writeln(
          'Before proceeding, verify database connection details:\n'
          ' - "$configFilePath": (host, port, database name, username)\n'
          ' - "$secretsFilePath": (database password)\n'
          ' - Ensure the database server is reachable from this machine',
        );
      }

      stdout.writeln('Press Enter to continue...');
      stdin.readLineSync();

      await repository.save(defaultSecrets);
      return defaultSecrets;
    }

    return appSecrets;
  } finally {
    if (repository.hasProvidedRequiredSecretsViaEnv()) {
      stdout.writeln(
        'All required app secrets were provided via environment variables',
      );
    }
  }
}

// TODO: (REMOVE_SERVERPOD) Setup the mail service provider and implement
// void _sendPasswordResetCode({
//   required String email,
//   required String verificationCode,
// }) {
//   session.log('[EmailIdp] Password reset code ($email): $verificationCode');
// }

Future<void> _maybeInstallSystemMdns({
  required MdnsServicePublishConfig config,
  required SetupPromptDeclinedConfig setupPromptDeclinedConfig,
  required String Function() getConfigFilePath,
  required AppConfigRepository appConfigRepository,
  required Shutdown shutdown,
}) async {
  if (!config.enabled || setupPromptDeclinedConfig.systemMdnsService) {
    return;
  }
  final platformInstaller = await resolveMdnsPlatformInstaller(
    shutdown: shutdown,
  );
  if (platformInstaller == null) {
    stdout.writeln(
      'Automatic mDNS service installation is not supported by the program on this system.',
    );
    return;
  }
  final installer = MdnsInstaller(
    platform: platformInstaller,
    getConfigFilePath: getConfigFilePath,
  );
  await installer.tryInstallWithPrompt(
    onDeclined: () => appConfigRepository.update(
      setupPromptDeclined: setupPromptDeclinedConfig.copyWith(
        systemMdnsService: true,
      ),
    ),
  );
}

Future<void> _registerMdnsService({
  required int serverPort,
  required ShutdownHookRegistry shutdownHookRegistry,
  required String instanceName,
}) async {
  final registrar = MdnsServiceRegistrar(
    platform: await resolveMdnsPlatformRegistrar(),
  );
  await registrar.start(port: serverPort, instanceName: instanceName);

  shutdownHookRegistry.register('stoppingMdnsService', () async {
    stdout.writeln('Stopping mDNS service...');
    await registrar.stop();
  });
}

Future<void> _registerProcessShutdownSignalHandlers(Shutdown shutdown) async {
  Future<void> handleSignal(ProcessSignal signal) async {
    stdout.writeln('Received signal: $signal');
    await shutdown(isSuccess: true);
  }

  ProcessSignal.sigint.watch().listen(handleSignal);

  if (!isWindows) {
    ProcessSignal.sigterm.watch().listen(handleSignal);
  }
}
