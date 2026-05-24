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
	late final TranslationsServerHandshakeEn serverHandshake = TranslationsServerHandshakeEn.internal(_root);
	late final TranslationsServerSelectionEn serverSelection = TranslationsServerSelectionEn.internal(_root);
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

// Path: serverHandshake
class TranslationsServerHandshakeEn {
	TranslationsServerHandshakeEn.internal(this._root);

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
class TranslationsServerSelectionEn {
	TranslationsServerSelectionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerSelectionLocalNetworkDiscoveryEn localNetworkDiscovery = TranslationsServerSelectionLocalNetworkDiscoveryEn.internal(_root);
	late final TranslationsServerSelectionManualAddressEn manualAddress = TranslationsServerSelectionManualAddressEn.internal(_root);
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

// Path: serverSelection.localNetworkDiscovery
class TranslationsServerSelectionLocalNetworkDiscoveryEn {
	TranslationsServerSelectionLocalNetworkDiscoveryEn.internal(this._root);

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

	late final TranslationsServerSelectionLocalNetworkDiscoveryTileMenuEn tileMenu = TranslationsServerSelectionLocalNetworkDiscoveryTileMenuEn.internal(_root);
	late final TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundEn noServersFound = TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundEn.internal(_root);
}

// Path: serverSelection.manualAddress
class TranslationsServerSelectionManualAddressEn {
	TranslationsServerSelectionManualAddressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter Server Address'
	String get button => 'Enter Server Address';

	/// en: 'Manually providing a server address.'
	String get tooltip => 'Manually providing a server address.';

	late final TranslationsServerSelectionManualAddressTextFieldEn textField = TranslationsServerSelectionManualAddressTextFieldEn.internal(_root);
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

// Path: serverSelection.localNetworkDiscovery.tileMenu
class TranslationsServerSelectionLocalNetworkDiscoveryTileMenuEn {
	TranslationsServerSelectionLocalNetworkDiscoveryTileMenuEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy IP & Port'
	String get copyIpAddressEndpoint => 'Copy IP & Port';

	/// en: 'Copy Hostname & Port'
	String get copyLocalHostnameEndpoint => 'Copy Hostname & Port';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound
class TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundEn {
	TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningEn doneScanning = TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningEn.internal(_root);
	late final TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundStillScanningEn stillScanning = TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundStillScanningEn.internal(_root);
}

// Path: serverSelection.manualAddress.textField
class TranslationsServerSelectionManualAddressTextFieldEn {
	TranslationsServerSelectionManualAddressTextFieldEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServerSelectionManualAddressTextFieldValidationErrorsEn validationErrors = TranslationsServerSelectionManualAddressTextFieldValidationErrorsEn.internal(_root);

	/// en: 'e.g., https://example.com'
	String get hint => 'e.g., https://example.com';

	/// en: 'Server URL'
	String get label => 'Server URL';

	/// en: 'Enter the URL of your server'
	String get helper => 'Enter the URL of your server';

	/// en: 'Can be provided by a service administrator or self-hosted.'
	String get infoTooltip => 'Can be provided by a service administrator or self-hosted.';
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

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning
class TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningEn {
	TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No servers found'
	String get title => 'No servers found';

	/// en: 'We scanned your local network but did not find any $appName servers'
	String subtitle({required Object appName}) => 'We scanned your local network but did not find\nany ${appName} servers';

	late final TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn troubleshootingTips = TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn.internal(_root);
	late final TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn hostServerGuideButton = TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn.internal(_root);
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.stillScanning
class TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundStillScanningEn {
	TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundStillScanningEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Scanning your network...'
	String get title => 'Scanning your network...';

	/// en: 'Scanning for $appName servers on your local network. This may take a few moments.'
	String subtitle({required Object appName}) => 'Scanning for ${appName} servers on your local network.\nThis may take a few moments.';
}

// Path: serverSelection.manualAddress.textField.validationErrors
class TranslationsServerSelectionManualAddressTextFieldValidationErrorsEn {
	TranslationsServerSelectionManualAddressTextFieldValidationErrorsEn.internal(this._root);

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
class TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn {
	TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningTroubleshootingTipsEn.internal(this._root);

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
class TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn {
	TranslationsServerSelectionLocalNetworkDiscoveryNoServersFoundDoneScanningHostServerGuideButtonEn.internal(this._root);

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
			_ => null,
		};
	}
}
