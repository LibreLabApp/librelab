import 'dart:io';

import 'package:collection/collection.dart';
import 'package:librelab_server/generated/pubspec.g.dart';
import 'package:librelab_server/src/auth/ensure_has_admin_user.dart';
import 'package:librelab_server/src/config/app_config.dart';
import 'package:librelab_server/src/config/app_config_repository.dart';
import 'package:librelab_server/src/config/ensure_config_secrets.dart';
import 'package:librelab_server/src/constants/constants.dart';
import 'package:librelab_server/src/generated/endpoints.dart';
import 'package:librelab_server/src/generated/protocol.dart';
import 'package:librelab_server/src/mdns/mdns_driver.dart';
import 'package:librelab_server/src/mdns/mdns_service_advertiser.dart';
import 'package:librelab_server/src/mdns/prompt_mdns_config.dart';
import 'package:librelab_server/src/postgres_installer/postgres_installer.dart';
import 'package:librelab_server/src/utils/platform_check.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

Future<void> run(List<String> args) async {
  stdout.writeln(
    'Server version: ${Pubspec.version}\n'
    'Arguments: $args\n'
    'Current directory: ${Directory.current.absolute.path}\n'
    'Operating system: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}\n',
  );

  await ensureHasConfigSecrets();

  // Workaround: This app supports custom arguments. Serverpod fails
  // to parse and will use default values if there is an unrecognized argument.
  // Ideally we should address the core issue, but for now this workaround is sufficient.
  final withoutAppArgs = args
      .where(
        (argument) =>
            _AppArgument.values.firstWhereOrNull(
              (appArgument) => appArgument.argument == argument,
            ) ==
            null,
      )
      .toList();

  final pod = Serverpod(withoutAppArgs, Protocol(), Endpoints());

  pod.initializeAuthServices(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      EmailIdpConfigFromPasswords(
        // In this project, a new user can be registered with the help of another user.
        sendRegistrationVerificationCode: null,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  final appConfigRepository = AppConfigRepository(runMode: pod.runMode);
  final appConfig = await _loadAppConfig(appConfigRepository);

  final dbConfig =
      pod.config.database ??
      (throw Exception('Database connection configuration must be provided'));

  if (!appConfig.postgresInstallDeclined) {
    await tryInstallPostgresWithPrompt(
      appUser: dbConfig.user,
      appPassword: dbConfig.password,
      appDatabaseName: dbConfig.name,
      onDeclined: () =>
          appConfigRepository.update(postgresInstallDeclined: true),
    );
  }

  await pod.start();

  final mdnsConfig = appConfigRepository.configOrThrow.mdns;

  if (mdnsConfig.advertise) {
    final mdnsServiceAdvertiser = MdnsServiceAdvertiser(
      driver: isMacOS
          ? ProcessMdnsDriver.macOS(
              logStdout: pod.runMode == ServerpodRunMode.development,
            )
          : MdnsDriver.dart(),
    );
    await mdnsServiceAdvertiser.start(
      port: pod.server.port,
      instanceName: mdnsConfig.instanceName,
    );
    pod.experimental.shutdownTasks.addTask('stopMdnsAdvertising', () async {
      await mdnsServiceAdvertiser.stop();
    });
  }

  await _initializeAdminUser(
    forceCreateAdminUser: args.contains(_AppArgument.forceCreateAdmin.argument),
  );
}

Future<void> _initializeAdminUser({required bool forceCreateAdminUser}) async {
  final internalSession = await Serverpod.instance.createSession();
  try {
    // Must run after starting the server to ensure the initial database migration is applied.
    if (forceCreateAdminUser) {
      await createAdminUser(internalSession);
    } else {
      await ensureHasAdminUser(internalSession);
    }
  } finally {
    await internalSession.close();
  }
}

Future<AppConfig> _loadAppConfig(
  AppConfigRepository appConfigRepository,
) async {
  final appConfig = await appConfigRepository.load();
  if (appConfig == null) {
    final defaultConfig = AppConfig.defaultConfig(mdns: promptMdnsConfig());
    await appConfigRepository.save(defaultConfig);

    return defaultConfig;
  }
  return appConfig;
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // TODO: Setup the mail service provider
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
}

enum _AppArgument {
  forceCreateAdmin(argument: Constants.forceCreateAdminArgument);

  const _AppArgument({required this.argument});

  final String argument;
}
