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
	late final TranslationsInitialSetupPageEn initialSetupPage = TranslationsInitialSetupPageEn.internal(_root);
	late final TranslationsConfirmProgramExitDialogEn confirmProgramExitDialog = TranslationsConfirmProgramExitDialogEn.internal(_root);
	late final TranslationsServerEn server = TranslationsServerEn.internal(_root);
	late final TranslationsWorkInProgressEn workInProgress = TranslationsWorkInProgressEn.internal(_root);
}

// Path: initialSetupPage
class TranslationsInitialSetupPageEn {
	TranslationsInitialSetupPageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Title for initial setup page. This covers the entire first-time configuration flow, including preferences, server connection, and account setup.
	///
	/// en: 'Initial Setup'
	String get title => 'Initial Setup';

	late final TranslationsInitialSetupPageStepsEn steps = TranslationsInitialSetupPageStepsEn.internal(_root);

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Back'
	String get back => 'Back';

	late final TranslationsInitialSetupPageDecorativeAnimationEn decorativeAnimation = TranslationsInitialSetupPageDecorativeAnimationEn.internal(_root);
}

// Path: confirmProgramExitDialog
class TranslationsConfirmProgramExitDialogEn {
	TranslationsConfirmProgramExitDialogEn.internal(this._root);

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

// Path: server
class TranslationsServerEn {
	TranslationsServerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerTestConnectionEn testConnection = TranslationsServerTestConnectionEn.internal(_root);
	late final TranslationsServerConnectionMethodEn connectionMethod = TranslationsServerConnectionMethodEn.internal(_root);
	late final TranslationsServerLocalNetworkDiscoveryEn localNetworkDiscovery = TranslationsServerLocalNetworkDiscoveryEn.internal(_root);
}

// Path: workInProgress
class TranslationsWorkInProgressEn {
	TranslationsWorkInProgressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Under Construction!'
	String get title => 'Under Construction!';

	/// en: 'Watch your step! We are still laying down the code for this feature. Check back soon!'
	String get subtitle => 'Watch your step! We are still laying down the code for this feature. Check back soon!';
}

// Path: initialSetupPage.steps
class TranslationsInitialSetupPageStepsEn {
	TranslationsInitialSetupPageStepsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInitialSetupPageStepsPreferencesEn preferences = TranslationsInitialSetupPageStepsPreferencesEn.internal(_root);
	late final TranslationsInitialSetupPageStepsServerEn server = TranslationsInitialSetupPageStepsServerEn.internal(_root);
	late final TranslationsInitialSetupPageStepsAccountEn account = TranslationsInitialSetupPageStepsAccountEn.internal(_root);
	late final TranslationsInitialSetupPageStepsCompleteEn complete = TranslationsInitialSetupPageStepsCompleteEn.internal(_root);
}

// Path: initialSetupPage.decorativeAnimation
class TranslationsInitialSetupPageDecorativeAnimationEn {
	TranslationsInitialSetupPageDecorativeAnimationEn.internal(this._root);

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

// Path: server.testConnection
class TranslationsServerTestConnectionEn {
	TranslationsServerTestConnectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Test your connection'
	String get title => 'Test your connection';

	/// en: 'Make sure you can connect to your server before continuing.'
	String get subtitle => 'Make sure you can connect to your server before continuing.';

	/// en: 'Test Connection'
	String get button => 'Test Connection';
}

// Path: server.connectionMethod
class TranslationsServerConnectionMethodEn {
	TranslationsServerConnectionMethodEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerConnectionMethodLocalNetworkDiscoveryEn localNetworkDiscovery = TranslationsServerConnectionMethodLocalNetworkDiscoveryEn.internal(_root);
	late final TranslationsServerConnectionMethodManualAddressEn manualAddress = TranslationsServerConnectionMethodManualAddressEn.internal(_root);
}

// Path: server.localNetworkDiscovery
class TranslationsServerLocalNetworkDiscoveryEn {
	TranslationsServerLocalNetworkDiscoveryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

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

	late final TranslationsServerLocalNetworkDiscoveryNoServersFoundEn noServersFound = TranslationsServerLocalNetworkDiscoveryNoServersFoundEn.internal(_root);
}

// Path: initialSetupPage.steps.preferences
class TranslationsInitialSetupPageStepsPreferencesEn {
	TranslationsInitialSetupPageStepsPreferencesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInitialSetupPageStepsPreferencesNavEn nav = TranslationsInitialSetupPageStepsPreferencesNavEn.internal(_root);
	late final TranslationsInitialSetupPageStepsPreferencesContentEn content = TranslationsInitialSetupPageStepsPreferencesContentEn.internal(_root);
}

// Path: initialSetupPage.steps.server
class TranslationsInitialSetupPageStepsServerEn {
	TranslationsInitialSetupPageStepsServerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInitialSetupPageStepsServerNavEn nav = TranslationsInitialSetupPageStepsServerNavEn.internal(_root);
	late final TranslationsInitialSetupPageStepsServerContentEn content = TranslationsInitialSetupPageStepsServerContentEn.internal(_root);
}

// Path: initialSetupPage.steps.account
class TranslationsInitialSetupPageStepsAccountEn {
	TranslationsInitialSetupPageStepsAccountEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInitialSetupPageStepsAccountNavEn nav = TranslationsInitialSetupPageStepsAccountNavEn.internal(_root);
	late final TranslationsInitialSetupPageStepsAccountContentEn content = TranslationsInitialSetupPageStepsAccountContentEn.internal(_root);
}

// Path: initialSetupPage.steps.complete
class TranslationsInitialSetupPageStepsCompleteEn {
	TranslationsInitialSetupPageStepsCompleteEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsInitialSetupPageStepsCompleteNavEn nav = TranslationsInitialSetupPageStepsCompleteNavEn.internal(_root);
	late final TranslationsInitialSetupPageStepsCompleteContentEn content = TranslationsInitialSetupPageStepsCompleteContentEn.internal(_root);
}

// Path: server.connectionMethod.localNetworkDiscovery
class TranslationsServerConnectionMethodLocalNetworkDiscoveryEn {
	TranslationsServerConnectionMethodLocalNetworkDiscoveryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find on Network'
	String get button => 'Find on Network';

	/// en: 'Detect servers available on local network'
	String get tooltip => 'Detect servers available on local network';
}

// Path: server.connectionMethod.manualAddress
class TranslationsServerConnectionMethodManualAddressEn {
	TranslationsServerConnectionMethodManualAddressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Server Address'
	String get button => 'Enter Server Address';

	/// en: 'Manually providing a server address.'
	String get tooltip => 'Manually providing a server address.';
}

// Path: server.localNetworkDiscovery.noServersFound
class TranslationsServerLocalNetworkDiscoveryNoServersFoundEn {
	TranslationsServerLocalNetworkDiscoveryNoServersFoundEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningEn doneScanning = TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningEn.internal(_root);
	late final TranslationsServerLocalNetworkDiscoveryNoServersFoundStillScanningEn stillScanning = TranslationsServerLocalNetworkDiscoveryNoServersFoundStillScanningEn.internal(_root);
}

// Path: initialSetupPage.steps.preferences.nav
class TranslationsInitialSetupPageStepsPreferencesNavEn {
	TranslationsInitialSetupPageStepsPreferencesNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preferences'
	String get title => 'Preferences';

	/// en: 'Choose your preferences'
	String get subtitle => 'Choose your preferences';
}

// Path: initialSetupPage.steps.preferences.content
class TranslationsInitialSetupPageStepsPreferencesContentEn {
	TranslationsInitialSetupPageStepsPreferencesContentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Personalization'
	String get title => 'Personalization';

	/// en: 'Adjust theme, language and interface options'
	String get subtitle => 'Adjust theme, language and interface options';
}

// Path: initialSetupPage.steps.server.nav
class TranslationsInitialSetupPageStepsServerNavEn {
	TranslationsInitialSetupPageStepsServerNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get title => 'Server';

	/// en: 'Configure your server connection'
	String get subtitle => 'Configure your server connection';
}

// Path: initialSetupPage.steps.server.content
class TranslationsInitialSetupPageStepsServerContentEn {
	TranslationsInitialSetupPageStepsServerContentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server Connection'
	String get title => 'Server Connection';

	/// en: 'Connect to a server to access and sync your data'
	String get subtitle => 'Connect to a server to access and sync your data';
}

// Path: initialSetupPage.steps.account.nav
class TranslationsInitialSetupPageStepsAccountNavEn {
	TranslationsInitialSetupPageStepsAccountNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get title => 'Account';

	/// en: 'Login using your credentials'
	String get subtitle => 'Login using your credentials';
}

// Path: initialSetupPage.steps.account.content
class TranslationsInitialSetupPageStepsAccountContentEn {
	TranslationsInitialSetupPageStepsAccountContentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign In'
	String get title => 'Sign In';

	/// en: 'Authenticate to continue the setup process'
	String get subtitle => 'Authenticate to continue the setup process';
}

// Path: initialSetupPage.steps.complete.nav
class TranslationsInitialSetupPageStepsCompleteNavEn {
	TranslationsInitialSetupPageStepsCompleteNavEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Complete'
	String get title => 'Complete';

	/// en: 'Finish setup'
	String get subtitle => 'Finish setup';
}

// Path: initialSetupPage.steps.complete.content
class TranslationsInitialSetupPageStepsCompleteContentEn {
	TranslationsInitialSetupPageStepsCompleteContentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ready to go!'
	String get title => 'Ready to go!';

	/// en: 'Your setup is complete'
	String get subtitle => 'Your setup is complete';
}

// Path: server.localNetworkDiscovery.noServersFound.doneScanning
class TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningEn {
	TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No servers found'
	String get title => 'No servers found';

	/// en: 'We scanned your local network but did not find any $appName servers'
	String subtitle({required Object appName}) => 'We scanned your local network but did not find\nany ${appName} servers';

	late final TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn troubleshootingTips = TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn.internal(_root);
	late final TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn hostServerGuideButton = TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn.internal(_root);
}

// Path: server.localNetworkDiscovery.noServersFound.stillScanning
class TranslationsServerLocalNetworkDiscoveryNoServersFoundStillScanningEn {
	TranslationsServerLocalNetworkDiscoveryNoServersFoundStillScanningEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Scanning your network...'
	String get title => 'Scanning your network...';

	/// en: 'Scanning for $appName servers on your local network. This may take a few moments.'
	String subtitle({required Object appName}) => 'Scanning for ${appName} servers on your local network.\nThis may take a few moments.';
}

// Path: server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips
class TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn {
	TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn.internal(this._root);

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

// Path: server.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton
class TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn {
	TranslationsServerLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn.internal(this._root);

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
			'initialSetupPage.steps.server.content.title' => 'Server Connection',
			'initialSetupPage.steps.server.content.subtitle' => 'Connect to a server to access and sync your data',
			'initialSetupPage.steps.account.nav.title' => 'Account',
			'initialSetupPage.steps.account.nav.subtitle' => 'Login using your credentials',
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
			'server.testConnection.title' => 'Test your connection',
			'server.testConnection.subtitle' => 'Make sure you can connect to your server before continuing.',
			'server.testConnection.button' => 'Test Connection',
			'server.connectionMethod.localNetworkDiscovery.button' => 'Find on Network',
			'server.connectionMethod.localNetworkDiscovery.tooltip' => 'Detect servers available on local network',
			'server.connectionMethod.manualAddress.button' => 'Enter Server Address',
			'server.connectionMethod.manualAddress.tooltip' => 'Manually providing a server address.',
			'server.localNetworkDiscovery.refreshServersButton' => 'Refresh',
			'server.localNetworkDiscovery.serverListTitle' => 'Available Servers',
			'server.localNetworkDiscovery.discoveredServerPrompt' => 'Select a server found on your local network.',
			'server.localNetworkDiscovery.discoveredServersCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Found ${n} server', other: 'Found ${n} servers', ), 
			'server.localNetworkDiscovery.noServersFound.doneScanning.title' => 'No servers found',
			'server.localNetworkDiscovery.noServersFound.doneScanning.subtitle' => ({required Object appName}) => 'We scanned your local network but did not find\nany ${appName} servers',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.title' => 'What you can do:',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.toggleButtonLabel' => 'Troubleshooting',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.serverNotRunning' => 'Make sure your server is running',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.sameNetwork' => 'Check that your device is on the same network as the server',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.refreshList' => 'Try refreshing the list',
			'server.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.manualEntry' => 'Or enter your server address manually',
			'server.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.tooltip' => 'Learn how to set up and host a server',
			'server.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.label' => 'How to host a server',
			'server.localNetworkDiscovery.noServersFound.stillScanning.title' => 'Scanning your network...',
			'server.localNetworkDiscovery.noServersFound.stillScanning.subtitle' => ({required Object appName}) => 'Scanning for ${appName} servers on your local network.\nThis may take a few moments.',
			'workInProgress.title' => 'Under Construction!',
			'workInProgress.subtitle' => 'Watch your step! We are still laying down the code for this feature. Check back soon!',
			_ => null,
		};
	}
}
