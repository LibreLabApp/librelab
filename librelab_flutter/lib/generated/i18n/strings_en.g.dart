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
			_ => null,
		};
	}
}
