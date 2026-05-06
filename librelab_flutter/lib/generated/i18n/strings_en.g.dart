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

// Path: initialSetupPage.steps.preferences
class TranslationsInitialSetupPageStepsPreferencesEn {
	TranslationsInitialSetupPageStepsPreferencesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preferences'
	String get title => 'Preferences';

	/// en: 'Choose your preferences'
	String get subtitle => 'Choose your preferences';
}

// Path: initialSetupPage.steps.server
class TranslationsInitialSetupPageStepsServerEn {
	TranslationsInitialSetupPageStepsServerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get title => 'Server';

	/// en: 'Configure your server connection'
	String get subtitle => 'Configure your server connection';
}

// Path: initialSetupPage.steps.account
class TranslationsInitialSetupPageStepsAccountEn {
	TranslationsInitialSetupPageStepsAccountEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get title => 'Account';

	/// en: 'Login using your credentials'
	String get subtitle => 'Login using your credentials';
}

// Path: initialSetupPage.steps.complete
class TranslationsInitialSetupPageStepsCompleteEn {
	TranslationsInitialSetupPageStepsCompleteEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Complete'
	String get title => 'Complete';

	/// en: 'Finish setup'
	String get subtitle => 'Finish setup';
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
			'initialSetupPage.steps.preferences.title' => 'Preferences',
			'initialSetupPage.steps.preferences.subtitle' => 'Choose your preferences',
			'initialSetupPage.steps.server.title' => 'Server',
			'initialSetupPage.steps.server.subtitle' => 'Configure your server connection',
			'initialSetupPage.steps.account.title' => 'Account',
			'initialSetupPage.steps.account.subtitle' => 'Login using your credentials',
			'initialSetupPage.steps.complete.title' => 'Complete',
			'initialSetupPage.steps.complete.subtitle' => 'Finish setup',
			'initialSetupPage.next' => 'Next',
			'initialSetupPage.back' => 'Back',
			'confirmProgramExitDialog.title' => 'Confirm Exit',
			'confirmProgramExitDialog.message' => 'Are you sure you want to exit? Unsaved changes may be lost.',
			'confirmProgramExitDialog.backupCheckbox' => 'Backup data before closing',
			'confirmProgramExitDialog.cancelButton' => 'Cancel',
			'confirmProgramExitDialog.confirmButton' => 'Exit',
			_ => null,
		};
	}
}
