///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$initialSetupPage$en initialSetupPage = Translations$initialSetupPage$en.internal(_root);
	late final Translations$confirmProgramExitDialog$en confirmProgramExitDialog = Translations$confirmProgramExitDialog$en.internal(_root);
	late final Translations$serverHandshake$en serverHandshake = Translations$serverHandshake$en.internal(_root);
	late final Translations$serverSelection$en serverSelection = Translations$serverSelection$en.internal(_root);
	late final Translations$workInProgress$en workInProgress = Translations$workInProgress$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
}

// Path: initialSetupPage
class Translations$initialSetupPage$en {
	Translations$initialSetupPage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Title for initial setup page. This covers the entire first-time configuration flow, including preferences, server connection, and account setup.
	///
	/// en: 'Initial Setup'
	String get title => 'Initial Setup';

	late final Translations$initialSetupPage$steps$en steps = Translations$initialSetupPage$steps$en.internal(_root);

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Back'
	String get back => 'Back';

	late final Translations$initialSetupPage$decorativeAnimation$en decorativeAnimation = Translations$initialSetupPage$decorativeAnimation$en.internal(_root);
}

// Path: confirmProgramExitDialog
class Translations$confirmProgramExitDialog$en {
	Translations$confirmProgramExitDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// The title displayed in the confirmation dialog when the user tries to close the application.
	///
	/// en: 'Confirm Exit'
	String get title => 'Confirm Exit';

	/// The body text of the exit confirmation dialog.
	///
	/// en: 'Are you sure you want to exit? Unsaved changes may be lost.'
	String get message => 'Are you sure you want to exit? Unsaved changes may be lost.';

	/// Label for the checkbox to trigger a data backup on exit.
	///
	/// en: 'Backup data before closing'
	String get backupCheckbox => 'Backup data before closing';

	/// Secondary button text to stay in the app and not close.
	///
	/// en: 'Cancel'
	String get cancelButton => 'Cancel';

	/// Primary button text to confirm closing the application.
	///
	/// en: 'Exit'
	String get confirmButton => 'Exit';
}

// Path: serverHandshake
class Translations$serverHandshake$en {
	Translations$serverHandshake$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Test your connection'
	String get title => 'Test your connection';

	/// en: 'Make sure you can connect to your server before continuing.'
	String get subtitle => 'Make sure you can connect to your server before continuing.';

	/// en: 'Test Connection'
	String get button => 'Test Connection';
}

// Path: serverSelection
class Translations$serverSelection$en {
	Translations$serverSelection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$localNetworkDiscovery$en localNetworkDiscovery = Translations$serverSelection$localNetworkDiscovery$en.internal(_root);
	late final Translations$serverSelection$manualAddress$en manualAddress = Translations$serverSelection$manualAddress$en.internal(_root);
}

// Path: workInProgress
class Translations$workInProgress$en {
	Translations$workInProgress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Under Construction!'
	String get title => 'Under Construction!';

	/// en: 'Watch your step! We are still laying down the code for this feature. Check back soon!'
	String get subtitle => 'Watch your step! We are still laying down the code for this feature. Check back soon!';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$locale$en locale = Translations$settings$locale$en.internal(_root);
	late final Translations$settings$themeMode$en themeMode = Translations$settings$themeMode$en.internal(_root);
	late final Translations$settings$useSystemColors$en useSystemColors = Translations$settings$useSystemColors$en.internal(_root);
	late final Translations$settings$useCustomAccentColor$en useCustomAccentColor = Translations$settings$useCustomAccentColor$en.internal(_root);
	late final Translations$settings$sendCrashReports$en sendCrashReports = Translations$settings$sendCrashReports$en.internal(_root);
}

// Path: initialSetupPage.steps
class Translations$initialSetupPage$steps$en {
	Translations$initialSetupPage$steps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$preferences$en preferences = Translations$initialSetupPage$steps$preferences$en.internal(_root);
	late final Translations$initialSetupPage$steps$server$en server = Translations$initialSetupPage$steps$server$en.internal(_root);
	late final Translations$initialSetupPage$steps$account$en account = Translations$initialSetupPage$steps$account$en.internal(_root);
	late final Translations$initialSetupPage$steps$complete$en complete = Translations$initialSetupPage$steps$complete$en.internal(_root);
}

// Path: initialSetupPage.decorativeAnimation
class Translations$initialSetupPage$decorativeAnimation$en {
	Translations$initialSetupPage$decorativeAnimation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Title shown in the decorative animation on the initial setup page, step-independent. Not shown in smaller screens.
	///
	/// en: 'Almost there!'
	String get title => 'Almost there!';

	/// Subtitle shown in the decorative animation on the initial setup page. Not shown in smaller screens.
	///
	/// en: 'Let's get everything set up for you'
	String get subtitle => 'Let\'s get everything set up for you';
}

// Path: serverSelection.localNetworkDiscovery
class Translations$serverSelection$localNetworkDiscovery$en {
	Translations$serverSelection$localNetworkDiscovery$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find on Network'
	String get button => 'Find on Network';

	/// en: 'Detect servers available on local network'
	String get tooltip => 'Detect servers available on local network';

	/// en: 'Refresh'
	String get refreshServersButton => 'Refresh';

	/// en: 'Available Servers'
	String get serverListTitle => 'Available Servers';

	/// en: 'Select a server found on your local network.'
	String get discoveredServerPrompt => 'Select a server found on your local network.';

	/// en: '(one) {Found $n server} (other) {Found $n servers}'
	String discoveredServersCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Found ${n} server',
		other: 'Found ${n} servers',
	);

	late final Translations$serverSelection$localNetworkDiscovery$tileMenu$en tileMenu = Translations$serverSelection$localNetworkDiscovery$tileMenu$en.internal(_root);
	late final Translations$serverSelection$localNetworkDiscovery$noServersFound$en noServersFound = Translations$serverSelection$localNetworkDiscovery$noServersFound$en.internal(_root);
}

// Path: serverSelection.manualAddress
class Translations$serverSelection$manualAddress$en {
	Translations$serverSelection$manualAddress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Server Address'
	String get button => 'Enter Server Address';

	/// en: 'Manually providing a server address.'
	String get tooltip => 'Manually providing a server address.';

	late final Translations$serverSelection$manualAddress$textField$en textField = Translations$serverSelection$manualAddress$textField$en.internal(_root);
}

// Path: settings.locale
class Translations$settings$locale$en {
	Translations$settings$locale$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App Language'
	String get title => 'App Language';

	/// en: 'Choose your preferred language'
	String get subtitle => 'Choose your preferred language';

	/// en: 'System'
	String get systemDefault => 'System';
}

// Path: settings.themeMode
class Translations$settings$themeMode$en {
	Translations$settings$themeMode$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Theme Mode'
	String get title => 'Theme Mode';

	/// en: 'Select dark, light or system theme'
	String get subtitle => 'Select dark, light or system theme';

	late final Translations$settings$themeMode$options$en options = Translations$settings$themeMode$options$en.internal(_root);
}

// Path: settings.useSystemColors
class Translations$settings$useSystemColors$en {
	Translations$settings$useSystemColors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inherit System Colors'
	String get title => 'Inherit System Colors';

	/// en: 'Automatically adapt to the system colors'
	String get subtitle => 'Automatically adapt to the system colors';
}

// Path: settings.useCustomAccentColor
class Translations$settings$useCustomAccentColor$en {
	Translations$settings$useCustomAccentColor$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Custom Accent Color'
	String get title => 'Custom Accent Color';

	/// en: 'Customize the accent color of the app theme'
	String get subtitle => 'Customize the accent color of the app theme';

	late final Translations$settings$useCustomAccentColor$pickColorDialog$en pickColorDialog = Translations$settings$useCustomAccentColor$pickColorDialog$en.internal(_root);
}

// Path: settings.sendCrashReports
class Translations$settings$sendCrashReports$en {
	Translations$settings$sendCrashReports$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Send Crash Reports'
	String get title => 'Send Crash Reports';

	/// en: 'Help Improve $appName by sending anonymous crash reports'
	String subtitle({required Object appName}) => 'Help Improve ${appName} by sending anonymous crash reports';
}

// Path: initialSetupPage.steps.preferences
class Translations$initialSetupPage$steps$preferences$en {
	Translations$initialSetupPage$steps$preferences$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$preferences$nav$en nav = Translations$initialSetupPage$steps$preferences$nav$en.internal(_root);
	late final Translations$initialSetupPage$steps$preferences$content$en content = Translations$initialSetupPage$steps$preferences$content$en.internal(_root);
}

// Path: initialSetupPage.steps.server
class Translations$initialSetupPage$steps$server$en {
	Translations$initialSetupPage$steps$server$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$server$nav$en nav = Translations$initialSetupPage$steps$server$nav$en.internal(_root);
	late final Translations$initialSetupPage$steps$server$content$en content = Translations$initialSetupPage$steps$server$content$en.internal(_root);
}

// Path: initialSetupPage.steps.account
class Translations$initialSetupPage$steps$account$en {
	Translations$initialSetupPage$steps$account$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$account$nav$en nav = Translations$initialSetupPage$steps$account$nav$en.internal(_root);
	late final Translations$initialSetupPage$steps$account$content$en content = Translations$initialSetupPage$steps$account$content$en.internal(_root);
}

// Path: initialSetupPage.steps.complete
class Translations$initialSetupPage$steps$complete$en {
	Translations$initialSetupPage$steps$complete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$complete$nav$en nav = Translations$initialSetupPage$steps$complete$nav$en.internal(_root);
	late final Translations$initialSetupPage$steps$complete$content$en content = Translations$initialSetupPage$steps$complete$content$en.internal(_root);
}

// Path: serverSelection.localNetworkDiscovery.tileMenu
class Translations$serverSelection$localNetworkDiscovery$tileMenu$en {
	Translations$serverSelection$localNetworkDiscovery$tileMenu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy IP & Port'
	String get copyIpAddressEndpoint => 'Copy IP & Port';

	/// en: 'Copy Hostname & Port'
	String get copyLocalHostnameEndpoint => 'Copy Hostname & Port';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound
class Translations$serverSelection$localNetworkDiscovery$noServersFound$en {
	Translations$serverSelection$localNetworkDiscovery$noServersFound$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$en doneScanning = Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$en.internal(_root);
	late final Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$en stillScanning = Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$en.internal(_root);
}

// Path: serverSelection.manualAddress.textField
class Translations$serverSelection$manualAddress$textField$en {
	Translations$serverSelection$manualAddress$textField$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$manualAddress$textField$validationErrors$en validationErrors = Translations$serverSelection$manualAddress$textField$validationErrors$en.internal(_root);

	/// en: 'e.g., https://example.com'
	String get hint => 'e.g., https://example.com';

	/// en: 'Server URL'
	String get label => 'Server URL';

	/// en: 'Enter the URL of your server'
	String get helper => 'Enter the URL of your server';

	/// en: 'Can be provided by a service administrator or self-hosted.'
	String get infoTooltip => 'Can be provided by a service administrator or self-hosted.';
}

// Path: settings.themeMode.options
class Translations$settings$themeMode$options$en {
	Translations$settings$themeMode$options$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'System'
	String get system => 'System';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'Light'
	String get light => 'Light';
}

// Path: settings.useCustomAccentColor.pickColorDialog
class Translations$settings$useCustomAccentColor$pickColorDialog$en {
	Translations$settings$useCustomAccentColor$pickColorDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pick a Color'
	String get title => 'Pick a Color';

	/// en: 'Close'
	String get close => 'Close';
}

// Path: initialSetupPage.steps.preferences.nav
class Translations$initialSetupPage$steps$preferences$nav$en {
	Translations$initialSetupPage$steps$preferences$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preferences'
	String get title => 'Preferences';

	/// en: 'Choose your preferences'
	String get subtitle => 'Choose your preferences';
}

// Path: initialSetupPage.steps.preferences.content
class Translations$initialSetupPage$steps$preferences$content$en {
	Translations$initialSetupPage$steps$preferences$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Personalization'
	String get title => 'Personalization';

	/// en: 'Adjust theme, language and interface options'
	String get subtitle => 'Adjust theme, language and interface options';
}

// Path: initialSetupPage.steps.server.nav
class Translations$initialSetupPage$steps$server$nav$en {
	Translations$initialSetupPage$steps$server$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get title => 'Server';

	/// en: 'Configure your server connection'
	String get subtitle => 'Configure your server connection';

	/// en: 'Please select a server and test the connection first'
	String get prerequisiteStepIncomplete => 'Please select a server and test the connection first';
}

// Path: initialSetupPage.steps.server.content
class Translations$initialSetupPage$steps$server$content$en {
	Translations$initialSetupPage$steps$server$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server Connection'
	String get title => 'Server Connection';

	/// en: 'Connect to a server to access and sync your data'
	String get subtitle => 'Connect to a server to access and sync your data';
}

// Path: initialSetupPage.steps.account.nav
class Translations$initialSetupPage$steps$account$nav$en {
	Translations$initialSetupPage$steps$account$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get title => 'Account';

	/// en: 'Login using your credentials'
	String get subtitle => 'Login using your credentials';

	/// en: 'Complete account setup first'
	String get prerequisiteStepIncomplete => 'Complete account setup first';
}

// Path: initialSetupPage.steps.account.content
class Translations$initialSetupPage$steps$account$content$en {
	Translations$initialSetupPage$steps$account$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign In'
	String get title => 'Sign In';

	/// en: 'Authenticate to continue the setup process'
	String get subtitle => 'Authenticate to continue the setup process';
}

// Path: initialSetupPage.steps.complete.nav
class Translations$initialSetupPage$steps$complete$nav$en {
	Translations$initialSetupPage$steps$complete$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Complete'
	String get title => 'Complete';

	/// en: 'Finish setup'
	String get subtitle => 'Finish setup';
}

// Path: initialSetupPage.steps.complete.content
class Translations$initialSetupPage$steps$complete$content$en {
	Translations$initialSetupPage$steps$complete$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ready to go!'
	String get title => 'Ready to go!';

	/// en: 'Your setup is complete'
	String get subtitle => 'Your setup is complete';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning
class Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$en {
	Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No servers found'
	String get title => 'No servers found';

	/// en: 'We scanned your local network but did not find any $appName servers'
	String subtitle({required Object appName}) => 'We scanned your local network but did not find\nany ${appName} servers';

	late final Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$en troubleshootingTips = Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$en.internal(_root);
	late final Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$en hostServerGuideButton = Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$en.internal(_root);
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.stillScanning
class Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$en {
	Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Scanning your network...'
	String get title => 'Scanning your network...';

	/// en: 'Scanning for $appName servers on your local network. This may take a few moments.'
	String subtitle({required Object appName}) => 'Scanning for ${appName} servers on your local network.\nThis may take a few moments.';
}

// Path: serverSelection.manualAddress.textField.validationErrors
class Translations$serverSelection$manualAddress$textField$validationErrors$en {
	Translations$serverSelection$manualAddress$textField$validationErrors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A URL is required'
	String get emptyInput => 'A URL is required';

	/// en: 'Must be a valid URL'
	String get invalidUri => 'Must be a valid URL';

	/// en: 'Protocol is required (e.g., https://)'
	String get missingScheme => 'Protocol is required (e.g., https://)';

	/// en: 'Unsupported protocol: $scheme'
	String unsupportedScheme({required Object scheme}) => 'Unsupported protocol: ${scheme}';

	/// en: 'A host is required'
	String get missingHost => 'A host is required';

	/// en: 'Invalid port: $port'
	String invalidPort({required Object port}) => 'Invalid port: ${port}';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips
class Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$en {
	Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What you can do:'
	String get title => 'What you can do:';

	/// en: 'Troubleshooting'
	String get toggleButtonLabel => 'Troubleshooting';

	/// en: 'Make sure your server is running'
	String get serverNotRunning => 'Make sure your server is running';

	/// en: 'Check that your device is on the same network as the server'
	String get sameNetwork => 'Check that your device is on the same network as the server';

	/// en: 'Try refreshing the list'
	String get refreshList => 'Try refreshing the list';

	/// en: 'Or enter your server address manually'
	String get manualEntry => 'Or enter your server address manually';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton
class Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$en {
	Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Learn how to set up and host a server'
	String get tooltip => 'Learn how to set up and host a server';

	/// en: 'How to host a server'
	String get label => 'How to host a server';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'initialSetupPage.title' => 'Initial Setup',
			'initialSetupPage.steps.preferences.nav.title' => 'Preferences',
			'initialSetupPage.steps.preferences.nav.subtitle' => 'Choose your preferences',
			'initialSetupPage.steps.preferences.content.title' => 'Personalization',
			'initialSetupPage.steps.preferences.content.subtitle' => 'Adjust theme, language and interface options',
			'initialSetupPage.steps.server.nav.title' => 'Server',
			'initialSetupPage.steps.server.nav.subtitle' => 'Configure your server connection',
			'initialSetupPage.steps.server.nav.prerequisiteStepIncomplete' => 'Please select a server and test the connection first',
			'initialSetupPage.steps.server.content.title' => 'Server Connection',
			'initialSetupPage.steps.server.content.subtitle' => 'Connect to a server to access and sync your data',
			'initialSetupPage.steps.account.nav.title' => 'Account',
			'initialSetupPage.steps.account.nav.subtitle' => 'Login using your credentials',
			'initialSetupPage.steps.account.nav.prerequisiteStepIncomplete' => 'Complete account setup first',
			'initialSetupPage.steps.account.content.title' => 'Sign In',
			'initialSetupPage.steps.account.content.subtitle' => 'Authenticate to continue the setup process',
			'initialSetupPage.steps.complete.nav.title' => 'Complete',
			'initialSetupPage.steps.complete.nav.subtitle' => 'Finish setup',
			'initialSetupPage.steps.complete.content.title' => 'Ready to go!',
			'initialSetupPage.steps.complete.content.subtitle' => 'Your setup is complete',
			'initialSetupPage.next' => 'Next',
			'initialSetupPage.back' => 'Back',
			'initialSetupPage.decorativeAnimation.title' => 'Almost there!',
			'initialSetupPage.decorativeAnimation.subtitle' => 'Let\'s get everything set up for you',
			'confirmProgramExitDialog.title' => 'Confirm Exit',
			'confirmProgramExitDialog.message' => 'Are you sure you want to exit? Unsaved changes may be lost.',
			'confirmProgramExitDialog.backupCheckbox' => 'Backup data before closing',
			'confirmProgramExitDialog.cancelButton' => 'Cancel',
			'confirmProgramExitDialog.confirmButton' => 'Exit',
			'serverHandshake.title' => 'Test your connection',
			'serverHandshake.subtitle' => 'Make sure you can connect to your server before continuing.',
			'serverHandshake.button' => 'Test Connection',
			'serverSelection.localNetworkDiscovery.button' => 'Find on Network',
			'serverSelection.localNetworkDiscovery.tooltip' => 'Detect servers available on local network',
			'serverSelection.localNetworkDiscovery.refreshServersButton' => 'Refresh',
			'serverSelection.localNetworkDiscovery.serverListTitle' => 'Available Servers',
			'serverSelection.localNetworkDiscovery.discoveredServerPrompt' => 'Select a server found on your local network.',
			'serverSelection.localNetworkDiscovery.discoveredServersCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Found ${n} server', other: 'Found ${n} servers', ), 
			'serverSelection.localNetworkDiscovery.tileMenu.copyIpAddressEndpoint' => 'Copy IP & Port',
			'serverSelection.localNetworkDiscovery.tileMenu.copyLocalHostnameEndpoint' => 'Copy Hostname & Port',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.title' => 'No servers found',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.subtitle' => ({required Object appName}) => 'We scanned your local network but did not find\nany ${appName} servers',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.title' => 'What you can do:',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.toggleButtonLabel' => 'Troubleshooting',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.serverNotRunning' => 'Make sure your server is running',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.sameNetwork' => 'Check that your device is on the same network as the server',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.refreshList' => 'Try refreshing the list',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.manualEntry' => 'Or enter your server address manually',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.tooltip' => 'Learn how to set up and host a server',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.label' => 'How to host a server',
			'serverSelection.localNetworkDiscovery.noServersFound.stillScanning.title' => 'Scanning your network...',
			'serverSelection.localNetworkDiscovery.noServersFound.stillScanning.subtitle' => ({required Object appName}) => 'Scanning for ${appName} servers on your local network.\nThis may take a few moments.',
			'serverSelection.manualAddress.button' => 'Enter Server Address',
			'serverSelection.manualAddress.tooltip' => 'Manually providing a server address.',
			'serverSelection.manualAddress.textField.validationErrors.emptyInput' => 'A URL is required',
			'serverSelection.manualAddress.textField.validationErrors.invalidUri' => 'Must be a valid URL',
			'serverSelection.manualAddress.textField.validationErrors.missingScheme' => 'Protocol is required (e.g., https://)',
			'serverSelection.manualAddress.textField.validationErrors.unsupportedScheme' => ({required Object scheme}) => 'Unsupported protocol: ${scheme}',
			'serverSelection.manualAddress.textField.validationErrors.missingHost' => 'A host is required',
			'serverSelection.manualAddress.textField.validationErrors.invalidPort' => ({required Object port}) => 'Invalid port: ${port}',
			'serverSelection.manualAddress.textField.hint' => 'e.g., https://example.com',
			'serverSelection.manualAddress.textField.label' => 'Server URL',
			'serverSelection.manualAddress.textField.helper' => 'Enter the URL of your server',
			'serverSelection.manualAddress.textField.infoTooltip' => 'Can be provided by a service administrator or self-hosted.',
			'workInProgress.title' => 'Under Construction!',
			'workInProgress.subtitle' => 'Watch your step! We are still laying down the code for this feature. Check back soon!',
			'settings.locale.title' => 'App Language',
			'settings.locale.subtitle' => 'Choose your preferred language',
			'settings.locale.systemDefault' => 'System',
			'settings.themeMode.title' => 'Theme Mode',
			'settings.themeMode.subtitle' => 'Select dark, light or system theme',
			'settings.themeMode.options.system' => 'System',
			'settings.themeMode.options.dark' => 'Dark',
			'settings.themeMode.options.light' => 'Light',
			'settings.useSystemColors.title' => 'Inherit System Colors',
			'settings.useSystemColors.subtitle' => 'Automatically adapt to the system colors',
			'settings.useCustomAccentColor.title' => 'Custom Accent Color',
			'settings.useCustomAccentColor.subtitle' => 'Customize the accent color of the app theme',
			'settings.useCustomAccentColor.pickColorDialog.title' => 'Pick a Color',
			'settings.useCustomAccentColor.pickColorDialog.close' => 'Close',
			'settings.sendCrashReports.title' => 'Send Crash Reports',
			'settings.sendCrashReports.subtitle' => ({required Object appName}) => 'Help Improve ${appName} by sending anonymous crash reports',
			_ => null,
		};
	}
}
