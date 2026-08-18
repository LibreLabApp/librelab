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
	late final Translations$serverCompatibility$en serverCompatibility = Translations$serverCompatibility$en.internal(_root);
	late final Translations$serverSelection$en serverSelection = Translations$serverSelection$en.internal(_root);
	late final Translations$workInProgress$en workInProgress = Translations$workInProgress$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$apiRequestFailures$en apiRequestFailures = Translations$apiRequestFailures$en.internal(_root);
	late final Translations$loginFormSection$en loginFormSection = Translations$loginFormSection$en.internal(_root);
	late final Translations$labSettingsForm$en labSettingsForm = Translations$labSettingsForm$en.internal(_root);

	/// en: '?'
	String get questionMark => '?';

	/// en: 'Retry'
	String get retry => 'Retry';

	late final Translations$filePicker$en filePicker = Translations$filePicker$en.internal(_root);
	late final Translations$imagePicker$en imagePicker = Translations$imagePicker$en.internal(_root);

	/// en: 'Copy error details'
	String get copyErrorDetails => 'Copy error details';

	late final Translations$homePage$en homePage = Translations$homePage$en.internal(_root);
}

// Path: initialSetupPage
class Translations$initialSetupPage$en {
	Translations$initialSetupPage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// Title for initial setup page. This covers the entire first-time configuration flow, including preferences, server selection, and account setup.
	///
	/// en: 'Initial Setup'
	String get title => 'Initial Setup';

	late final Translations$initialSetupPage$steps$en steps = Translations$initialSetupPage$steps$en.internal(_root);

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Finish'
	String get finish => 'Finish';

	/// en: 'Failed to complete setup.'
	String get finishFailure => 'Failed to complete setup.';

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

// Path: serverCompatibility
class Translations$serverCompatibility$en {
	Translations$serverCompatibility$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverCompatibility$check$en check = Translations$serverCompatibility$check$en.internal(_root);
}

// Path: serverSelection
class Translations$serverSelection$en {
	Translations$serverSelection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$browserPlatform$en browserPlatform = Translations$serverSelection$browserPlatform$en.internal(_root);
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
	late final Translations$settings$useAnimatedGraphics$en useAnimatedGraphics = Translations$settings$useAnimatedGraphics$en.internal(_root);
	late final Translations$settings$sendCrashReports$en sendCrashReports = Translations$settings$sendCrashReports$en.internal(_root);
}

// Path: apiRequestFailures
class Translations$apiRequestFailures$en {
	Translations$apiRequestFailures$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unable to connect to the server.'
	String get connection => 'Unable to connect to the server.';

	/// en: 'An unexpected error occurred.'
	String get unexpected => 'An unexpected error occurred.';

	/// en: 'An unexpected server response occurred.'
	String get unhandledServerResponse => 'An unexpected server response occurred.';

	/// en: 'Too many requests. Please try again later.'
	String get tooManyRequests => 'Too many requests. Please try again later.';

	/// en: 'Server is currently unavailable.'
	String get serviceUnavailable => 'Server is currently unavailable.';

	/// en: 'Internal server error occurred.'
	String get internalServer => 'Internal server error occurred.';

	/// en: 'Received malformed data from server.'
	String get malformedJson => 'Received malformed data from server.';

	/// en: 'Failed to parse server response.'
	String get jsonDeserialization => 'Failed to parse server response.';

	/// en: 'Authentication failed. Please sign in again.'
	String get unauthorized => 'Authentication failed. Please sign in again.';

	/// en: 'Access denied.'
	String get accessForbidden => 'Access denied.';
}

// Path: loginFormSection
class Translations$loginFormSection$en {
	Translations$loginFormSection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$loginFormSection$emailAddressTextField$en emailAddressTextField = Translations$loginFormSection$emailAddressTextField$en.internal(_root);
	late final Translations$loginFormSection$passwordTextField$en passwordTextField = Translations$loginFormSection$passwordTextField$en.internal(_root);

	/// en: 'Stay signed in'
	String get persistAuthSession => 'Stay signed in';

	late final Translations$loginFormSection$browserGuestModeNotice$en browserGuestModeNotice = Translations$loginFormSection$browserGuestModeNotice$en.internal(_root);

	/// en: 'Log in'
	String get loginButton => 'Log in';

	late final Translations$loginFormSection$loginFailures$en loginFailures = Translations$loginFormSection$loginFailures$en.internal(_root);

	/// en: 'Login failed'
	String get requestFailureTitle => 'Login failed';

	late final Translations$loginFormSection$loginSuccess$en loginSuccess = Translations$loginFormSection$loginSuccess$en.internal(_root);
	late final Translations$loginFormSection$loginCredentialsGuide$en loginCredentialsGuide = Translations$loginFormSection$loginCredentialsGuide$en.internal(_root);
}

// Path: labSettingsForm
class Translations$labSettingsForm$en {
	Translations$labSettingsForm$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$labSettingsForm$labNameTextField$en labNameTextField = Translations$labSettingsForm$labNameTextField$en.internal(_root);

	/// en: 'Update'
	String get updateButton => 'Update';

	/// en: 'Refresh'
	String get refreshButton => 'Refresh';

	late final Translations$labSettingsForm$fetch$en fetch = Translations$labSettingsForm$fetch$en.internal(_root);

	/// en: 'Failed to update lab information'
	String get updateFailureMessage => 'Failed to update lab information';

	/// en: 'Lab name is not set. The logged-in user lacks the required permission. Another user with this permission must provide the lab name.'
	String get labNameMissingWithoutUpdatePermissionMessage => 'Lab name is not set. The logged-in user lacks the required permission. Another user with this permission must provide the lab name.';
}

// Path: filePicker
class Translations$filePicker$en {
	Translations$filePicker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Failed to select the file.'
	String get pickFailure => 'Failed to select the file.';

	/// en: 'The selected file exceeds the maximum allowed size of $maxSize.'
	String exceedsMaximumSize({required Object maxSize}) => 'The selected file exceeds the maximum allowed size of ${maxSize}.';

	/// en: 'Failed to read the selected file.'
	String get readFailure => 'Failed to read the selected file.';
}

// Path: imagePicker
class Translations$imagePicker$en {
	Translations$imagePicker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change image'
	String get changeImage => 'Change image';

	/// en: 'Remove image'
	String get removeImage => 'Remove image';
}

// Path: homePage
class Translations$homePage$en {
	Translations$homePage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$homePage$destinations$en destinations = Translations$homePage$destinations$en.internal(_root);
	late final Translations$homePage$actions$en actions = Translations$homePage$actions$en.internal(_root);
}

// Path: initialSetupPage.steps
class Translations$initialSetupPage$steps$en {
	Translations$initialSetupPage$steps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$preferences$en preferences = Translations$initialSetupPage$steps$preferences$en.internal(_root);
	late final Translations$initialSetupPage$steps$serverSelection$en serverSelection = Translations$initialSetupPage$steps$serverSelection$en.internal(_root);
	late final Translations$initialSetupPage$steps$login$en login = Translations$initialSetupPage$steps$login$en.internal(_root);
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

// Path: serverCompatibility.check
class Translations$serverCompatibility$check$en {
	Translations$serverCompatibility$check$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverCompatibility$check$button$en button = Translations$serverCompatibility$check$button$en.internal(_root);
	late final Translations$serverCompatibility$check$idle$en idle = Translations$serverCompatibility$check$idle$en.internal(_root);
	late final Translations$serverCompatibility$check$loading$en loading = Translations$serverCompatibility$check$loading$en.internal(_root);
	late final Translations$serverCompatibility$check$success$en success = Translations$serverCompatibility$check$success$en.internal(_root);
	late final Translations$serverCompatibility$check$failure$en failure = Translations$serverCompatibility$check$failure$en.internal(_root);
}

// Path: serverSelection.browserPlatform
class Translations$serverSelection$browserPlatform$en {
	Translations$serverSelection$browserPlatform$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$browserPlatform$useWebAppServer$en useWebAppServer = Translations$serverSelection$browserPlatform$useWebAppServer$en.internal(_root);

	/// en: 'or'
	String get or => 'or';

	late final Translations$serverSelection$browserPlatform$manualAddress$en manualAddress = Translations$serverSelection$browserPlatform$manualAddress$en.internal(_root);
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

	late final Translations$serverSelection$localNetworkDiscovery$tile$en tile = Translations$serverSelection$localNetworkDiscovery$tile$en.internal(_root);
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

	/// en: 'Language'
	String get title => 'Language';

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

// Path: settings.useAnimatedGraphics
class Translations$settings$useAnimatedGraphics$en {
	Translations$settings$useAnimatedGraphics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Animated Graphics'
	String get title => 'Animated Graphics';

	/// en: 'Displays animations instead of static icons'
	String get subtitle => 'Displays animations instead of static icons';
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

// Path: loginFormSection.emailAddressTextField
class Translations$loginFormSection$emailAddressTextField$en {
	Translations$loginFormSection$emailAddressTextField$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$loginFormSection$emailAddressTextField$validationErrors$en validationErrors = Translations$loginFormSection$emailAddressTextField$validationErrors$en.internal(_root);

	/// en: 'Email address'
	String get label => 'Email address';

	/// en: 'you@example.org'
	String get hint => 'you@example.org';
}

// Path: loginFormSection.passwordTextField
class Translations$loginFormSection$passwordTextField$en {
	Translations$loginFormSection$passwordTextField$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$loginFormSection$passwordTextField$validationErrors$en validationErrors = Translations$loginFormSection$passwordTextField$validationErrors$en.internal(_root);

	/// en: 'Password'
	String get label => 'Password';

	late final Translations$loginFormSection$passwordTextField$visibility$en visibility = Translations$loginFormSection$passwordTextField$visibility$en.internal(_root);
}

// Path: loginFormSection.browserGuestModeNotice
class Translations$loginFormSection$browserGuestModeNotice$en {
	Translations$loginFormSection$browserGuestModeNotice$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not your device? Use Guest mode to sign in privately.'
	String get text => 'Not your device? Use Guest mode to sign in privately.';

	/// en: 'Learn more about using Guest mode'
	String get learnMore => 'Learn more about using Guest mode';
}

// Path: loginFormSection.loginFailures
class Translations$loginFormSection$loginFailures$en {
	Translations$loginFormSection$loginFailures$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invalid email or password.'
	String get invalidCredentials => 'Invalid email or password.';

	/// en: 'Login is disabled. Contact an administrator to enable it.'
	String get loginDisabled => 'Login is disabled. Contact an administrator to enable it.';

	/// en: 'The login input is invalid.'
	String get invalidInput => 'The login input is invalid.';
}

// Path: loginFormSection.loginSuccess
class Translations$loginFormSection$loginSuccess$en {
	Translations$loginFormSection$loginSuccess$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login successful'
	String get title => 'Login successful';

	/// en: 'Signed in as $fullName'
	String subtitle({required Object fullName}) => 'Signed in as ${fullName}';

	/// en: 'Log out'
	String get logout => 'Log out';
}

// Path: loginFormSection.loginCredentialsGuide
class Translations$loginFormSection$loginCredentialsGuide$en {
	Translations$loginFormSection$loginCredentialsGuide$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How to get login credentials'
	String get label => 'How to get login credentials';

	/// en: 'Contact your server administrator to obtain login credentials. The server prompts the administrator to create the first user, who can then create other users.'
	String get description => 'Contact your server administrator to obtain login credentials. The server prompts the administrator to create the first user, who can then create other users.';
}

// Path: labSettingsForm.labNameTextField
class Translations$labSettingsForm$labNameTextField$en {
	Translations$labSettingsForm$labNameTextField$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$labSettingsForm$labNameTextField$validationErrors$en validationErrors = Translations$labSettingsForm$labNameTextField$validationErrors$en.internal(_root);

	/// en: 'Lab name'
	String get label => 'Lab name';

	/// en: 'e.g., Central Diagnostic Laboratory'
	String get hint => 'e.g., Central Diagnostic Laboratory';
}

// Path: labSettingsForm.fetch
class Translations$labSettingsForm$fetch$en {
	Translations$labSettingsForm$fetch$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading lab information...'
	String get loadingMessage => 'Loading lab information...';

	/// en: 'Failed to load lab information'
	String get failureTitle => 'Failed to load lab information';
}

// Path: homePage.destinations
class Translations$homePage$destinations$en {
	Translations$homePage$destinations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$homePage$destinations$settings$en settings = Translations$homePage$destinations$settings$en.internal(_root);
}

// Path: homePage.actions
class Translations$homePage$actions$en {
	Translations$homePage$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Switch user'
	String get switchUser => 'Switch user';

	/// en: 'Log out'
	String get logout => 'Log out';
}

// Path: initialSetupPage.steps.preferences
class Translations$initialSetupPage$steps$preferences$en {
	Translations$initialSetupPage$steps$preferences$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$preferences$nav$en nav = Translations$initialSetupPage$steps$preferences$nav$en.internal(_root);
	late final Translations$initialSetupPage$steps$preferences$content$en content = Translations$initialSetupPage$steps$preferences$content$en.internal(_root);
}

// Path: initialSetupPage.steps.serverSelection
class Translations$initialSetupPage$steps$serverSelection$en {
	Translations$initialSetupPage$steps$serverSelection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$serverSelection$nav$en nav = Translations$initialSetupPage$steps$serverSelection$nav$en.internal(_root);

	/// en: 'Select a server and verify compatibility first.'
	String get prerequisiteStepIncomplete => 'Select a server and verify compatibility first.';

	late final Translations$initialSetupPage$steps$serverSelection$content$en content = Translations$initialSetupPage$steps$serverSelection$content$en.internal(_root);
}

// Path: initialSetupPage.steps.login
class Translations$initialSetupPage$steps$login$en {
	Translations$initialSetupPage$steps$login$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$login$nav$en nav = Translations$initialSetupPage$steps$login$nav$en.internal(_root);

	/// en: 'Complete log in first'
	String get prerequisiteStepIncomplete => 'Complete log in first';

	late final Translations$initialSetupPage$steps$login$content$en content = Translations$initialSetupPage$steps$login$content$en.internal(_root);
}

// Path: initialSetupPage.steps.complete
class Translations$initialSetupPage$steps$complete$en {
	Translations$initialSetupPage$steps$complete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$initialSetupPage$steps$complete$nav$en nav = Translations$initialSetupPage$steps$complete$nav$en.internal(_root);

	/// en: 'Lab name must be provided'
	String get prerequisiteStepIncomplete => 'Lab name must be provided';

	late final Translations$initialSetupPage$steps$complete$content$en content = Translations$initialSetupPage$steps$complete$content$en.internal(_root);
}

// Path: serverCompatibility.check.button
class Translations$serverCompatibility$check$button$en {
	Translations$serverCompatibility$check$button$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Test'
	String get label => 'Test';

	/// en: 'Select a server to continue.'
	String get serverSelectionRequired => 'Select a server to continue.';
}

// Path: serverCompatibility.check.idle
class Translations$serverCompatibility$check$idle$en {
	Translations$serverCompatibility$check$idle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verify compatibility'
	String get title => 'Verify compatibility';

	/// en: 'Verify the server is reachable before continuing.'
	String get subtitle => 'Verify the server is reachable before continuing.';
}

// Path: serverCompatibility.check.loading
class Translations$serverCompatibility$check$loading$en {
	Translations$serverCompatibility$check$loading$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verifying compatibility...'
	String get title => 'Verifying compatibility...';

	/// en: 'The server is being checked.'
	String get subtitle => 'The server is being checked.';
}

// Path: serverCompatibility.check.success
class Translations$serverCompatibility$check$success$en {
	Translations$serverCompatibility$check$success$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverCompatibility$check$success$compatibilityStatus$en compatibilityStatus = Translations$serverCompatibility$check$success$compatibilityStatus$en.internal(_root);
	late final Translations$serverCompatibility$check$success$connectionInfo$en connectionInfo = Translations$serverCompatibility$check$success$connectionInfo$en.internal(_root);

	/// en: 'Server version: $version+$buildNumber Connection URL: $serverUrl'
	String serverConnectionDetailsTooltip({required Object version, required Object buildNumber, required Object serverUrl}) => 'Server version: ${version}+${buildNumber}\nConnection URL: ${serverUrl}';
}

// Path: serverCompatibility.check.failure
class Translations$serverCompatibility$check$failure$en {
	Translations$serverCompatibility$check$failure$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compatibility check failed'
	String get title => 'Compatibility check failed';
}

// Path: serverSelection.browserPlatform.useWebAppServer
class Translations$serverSelection$browserPlatform$useWebAppServer$en {
	Translations$serverSelection$browserPlatform$useWebAppServer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Use this server'
	String get title => 'Use this server';

	/// en: 'Connect to the same server that is hosting this application'
	String get subtitle => 'Connect to the same server that is hosting this application';

	/// en: 'Server address:'
	String get serverAddressLabel => 'Server address:';

	/// en: 'Current Server'
	String get badge => 'Current Server';
}

// Path: serverSelection.browserPlatform.manualAddress
class Translations$serverSelection$browserPlatform$manualAddress$en {
	Translations$serverSelection$browserPlatform$manualAddress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Use a different server'
	String get title => 'Use a different server';

	/// en: 'Provide an external server address'
	String get subtitle => 'Provide an external server address';
}

// Path: serverSelection.localNetworkDiscovery.tile
class Translations$serverSelection$localNetworkDiscovery$tile$en {
	Translations$serverSelection$localNetworkDiscovery$tile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverSelection$localNetworkDiscovery$tile$menu$en menu = Translations$serverSelection$localNetworkDiscovery$tile$menu$en.internal(_root);

	/// en: '$latencyMs ms'
	String serverConnectionLatency({required Object latencyMs}) => '${latencyMs} ms';
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

	/// en: 'Enter the URL of the server'
	String get helper => 'Enter the URL of the server';

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

// Path: loginFormSection.emailAddressTextField.validationErrors
class Translations$loginFormSection$emailAddressTextField$validationErrors$en {
	Translations$loginFormSection$emailAddressTextField$validationErrors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'An email address is required'
	String get emptyInput => 'An email address is required';

	/// en: 'Must be a valid email address'
	String get invalidEmailAddress => 'Must be a valid email address';
}

// Path: loginFormSection.passwordTextField.validationErrors
class Translations$loginFormSection$passwordTextField$validationErrors$en {
	Translations$loginFormSection$passwordTextField$validationErrors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A password is required'
	String get emptyInput => 'A password is required';

	/// en: 'Password must be between 8 and 255 characters'
	String get invalidLength => 'Password must be between 8 and 255 characters';
}

// Path: loginFormSection.passwordTextField.visibility
class Translations$loginFormSection$passwordTextField$visibility$en {
	Translations$loginFormSection$passwordTextField$visibility$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show password'
	String get show => 'Show password';

	/// en: 'Hide password'
	String get hide => 'Hide password';
}

// Path: labSettingsForm.labNameTextField.validationErrors
class Translations$labSettingsForm$labNameTextField$validationErrors$en {
	Translations$labSettingsForm$labNameTextField$validationErrors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A lab name is required'
	String get emptyInput => 'A lab name is required';
}

// Path: homePage.destinations.settings
class Translations$homePage$destinations$settings$en {
	Translations$homePage$destinations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get label => 'Settings';
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

// Path: initialSetupPage.steps.serverSelection.nav
class Translations$initialSetupPage$steps$serverSelection$nav$en {
	Translations$initialSetupPage$steps$serverSelection$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get title => 'Server';

	/// en: 'Select the server'
	String get subtitle => 'Select the server';
}

// Path: initialSetupPage.steps.serverSelection.content
class Translations$initialSetupPage$steps$serverSelection$content$en {
	Translations$initialSetupPage$steps$serverSelection$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server Selection'
	String get title => 'Server Selection';

	/// en: 'Select a server to connect to and access your data'
	String get subtitle => 'Select a server to connect to and access your data';
}

// Path: initialSetupPage.steps.login.nav
class Translations$initialSetupPage$steps$login$nav$en {
	Translations$initialSetupPage$steps$login$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Log in'
	String get title => 'Log in';

	/// en: 'Log in with your credentials'
	String get subtitle => 'Log in with your credentials';
}

// Path: initialSetupPage.steps.login.content
class Translations$initialSetupPage$steps$login$content$en {
	Translations$initialSetupPage$steps$login$content$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Authenticate'
	String get title => 'Authenticate';

	/// en: 'Authenticate to access your account'
	String get subtitle => 'Authenticate to access your account';
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

	/// en: 'Lab information'
	String get title => 'Lab information';

	/// en: 'Complete your lab information to finish setup'
	String get subtitle => 'Complete your lab information to finish setup';
}

// Path: serverCompatibility.check.success.compatibilityStatus
class Translations$serverCompatibility$check$success$compatibilityStatus$en {
	Translations$serverCompatibility$check$success$compatibilityStatus$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverCompatibility$check$success$compatibilityStatus$fullyCompatible$en fullyCompatible = Translations$serverCompatibility$check$success$compatibilityStatus$fullyCompatible$en.internal(_root);
	late final Translations$serverCompatibility$check$success$compatibilityStatus$compatible$en compatible = Translations$serverCompatibility$check$success$compatibilityStatus$compatible$en.internal(_root);
	late final Translations$serverCompatibility$check$success$compatibilityStatus$updateClient$en updateClient = Translations$serverCompatibility$check$success$compatibilityStatus$updateClient$en.internal(_root);
	late final Translations$serverCompatibility$check$success$compatibilityStatus$updateServer$en updateServer = Translations$serverCompatibility$check$success$compatibilityStatus$updateServer$en.internal(_root);
}

// Path: serverCompatibility.check.success.connectionInfo
class Translations$serverCompatibility$check$success$connectionInfo$en {
	Translations$serverCompatibility$check$success$connectionInfo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$serverCompatibility$check$success$connectionInfo$http$en http = Translations$serverCompatibility$check$success$connectionInfo$http$en.internal(_root);
	late final Translations$serverCompatibility$check$success$connectionInfo$ipAddress$en ipAddress = Translations$serverCompatibility$check$success$connectionInfo$ipAddress$en.internal(_root);
	late final Translations$serverCompatibility$check$success$connectionInfo$httpAndIpAddress$en httpAndIpAddress = Translations$serverCompatibility$check$success$connectionInfo$httpAndIpAddress$en.internal(_root);
}

// Path: serverSelection.localNetworkDiscovery.tile.menu
class Translations$serverSelection$localNetworkDiscovery$tile$menu$en {
	Translations$serverSelection$localNetworkDiscovery$tile$menu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Copy IP & Port'
	String get copyIpAddressEndpoint => 'Copy IP & Port';

	/// en: 'Copy Hostname & Port'
	String get copyLocalHostnameEndpoint => 'Copy Hostname & Port';
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

	/// en: 'Unsupported protocol: $scheme'
	String unsupportedScheme({required Object scheme}) => 'Unsupported protocol: ${scheme}';

	/// en: 'A host is required'
	String get missingHost => 'A host is required';

	/// en: 'Invalid port: $port'
	String invalidPort({required Object port}) => 'Invalid port: ${port}';
}

// Path: serverCompatibility.check.success.compatibilityStatus.fullyCompatible
class Translations$serverCompatibility$check$success$compatibilityStatus$fullyCompatible$en {
	Translations$serverCompatibility$check$success$compatibilityStatus$fullyCompatible$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server is compatible'
	String get title => 'Server is compatible';

	/// en: 'The server is reachable and compatible.'
	String get subtitle => 'The server is reachable and compatible.';
}

// Path: serverCompatibility.check.success.compatibilityStatus.compatible
class Translations$serverCompatibility$check$success$compatibilityStatus$compatible$en {
	Translations$serverCompatibility$check$success$compatibilityStatus$compatible$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server is compatible'
	String get title => 'Server is compatible';

	/// en: 'A newer app version is available. Updating is recommended to prevent future breakage.'
	String get subtitle => 'A newer app version is available. Updating is recommended to prevent future breakage.';
}

// Path: serverCompatibility.check.success.compatibilityStatus.updateClient
class Translations$serverCompatibility$check$success$compatibilityStatus$updateClient$en {
	Translations$serverCompatibility$check$success$compatibilityStatus$updateClient$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update required'
	String get title => 'Update required';

	/// en: 'Update the app to continue with this server.'
	String get subtitle => 'Update the app to continue with this server.';
}

// Path: serverCompatibility.check.success.compatibilityStatus.updateServer
class Translations$serverCompatibility$check$success$compatibilityStatus$updateServer$en {
	Translations$serverCompatibility$check$success$compatibilityStatus$updateServer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update required'
	String get title => 'Update required';

	/// en: 'Update the server to continue with this app.'
	String get subtitle => 'Update the server to continue with this app.';
}

// Path: serverCompatibility.check.success.connectionInfo.http
class Translations$serverCompatibility$check$success$connectionInfo$http$en {
	Translations$serverCompatibility$check$success$connectionInfo$http$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connected over HTTP'
	String get title => 'Connected over HTTP';

	/// en: 'This connection is not encrypted. HTTPS is recommended to protect data exchanged with the server.'
	String get subtitle => 'This connection is not encrypted. HTTPS is recommended to protect data exchanged with the server.';
}

// Path: serverCompatibility.check.success.connectionInfo.ipAddress
class Translations$serverCompatibility$check$success$connectionInfo$ipAddress$en {
	Translations$serverCompatibility$check$success$connectionInfo$ipAddress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connected using an IP address'
	String get title => 'Connected using an IP address';

	/// en: 'The server's IP address may change over time, which can prevent future connections.'
	String get subtitle => 'The server\'s IP address may change over time, which can prevent future connections.';
}

// Path: serverCompatibility.check.success.connectionInfo.httpAndIpAddress
class Translations$serverCompatibility$check$success$connectionInfo$httpAndIpAddress$en {
	Translations$serverCompatibility$check$success$connectionInfo$httpAndIpAddress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connected over HTTP using an IP address'
	String get title => 'Connected over HTTP using an IP address';

	/// en: 'This connection is not encrypted, and the server's IP address may change over time, which can prevent future connections.'
	String get subtitle => 'This connection is not encrypted, and the server\'s IP address may change over time, which can prevent future connections.';
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
			'initialSetupPage.steps.serverSelection.nav.title' => 'Server',
			'initialSetupPage.steps.serverSelection.nav.subtitle' => 'Select the server',
			'initialSetupPage.steps.serverSelection.prerequisiteStepIncomplete' => 'Select a server and verify compatibility first.',
			'initialSetupPage.steps.serverSelection.content.title' => 'Server Selection',
			'initialSetupPage.steps.serverSelection.content.subtitle' => 'Select a server to connect to and access your data',
			'initialSetupPage.steps.login.nav.title' => 'Log in',
			'initialSetupPage.steps.login.nav.subtitle' => 'Log in with your credentials',
			'initialSetupPage.steps.login.prerequisiteStepIncomplete' => 'Complete log in first',
			'initialSetupPage.steps.login.content.title' => 'Authenticate',
			'initialSetupPage.steps.login.content.subtitle' => 'Authenticate to access your account',
			'initialSetupPage.steps.complete.nav.title' => 'Complete',
			'initialSetupPage.steps.complete.nav.subtitle' => 'Finish setup',
			'initialSetupPage.steps.complete.prerequisiteStepIncomplete' => 'Lab name must be provided',
			'initialSetupPage.steps.complete.content.title' => 'Lab information',
			'initialSetupPage.steps.complete.content.subtitle' => 'Complete your lab information to finish setup',
			'initialSetupPage.next' => 'Next',
			'initialSetupPage.back' => 'Back',
			'initialSetupPage.finish' => 'Finish',
			'initialSetupPage.finishFailure' => 'Failed to complete setup.',
			'initialSetupPage.decorativeAnimation.title' => 'Almost there!',
			'initialSetupPage.decorativeAnimation.subtitle' => 'Let\'s get everything set up for you',
			'confirmProgramExitDialog.title' => 'Confirm Exit',
			'confirmProgramExitDialog.message' => 'Are you sure you want to exit? Unsaved changes may be lost.',
			'confirmProgramExitDialog.backupCheckbox' => 'Backup data before closing',
			'confirmProgramExitDialog.cancelButton' => 'Cancel',
			'confirmProgramExitDialog.confirmButton' => 'Exit',
			'serverCompatibility.check.button.label' => 'Test',
			'serverCompatibility.check.button.serverSelectionRequired' => 'Select a server to continue.',
			'serverCompatibility.check.idle.title' => 'Verify compatibility',
			'serverCompatibility.check.idle.subtitle' => 'Verify the server is reachable before continuing.',
			'serverCompatibility.check.loading.title' => 'Verifying compatibility...',
			'serverCompatibility.check.loading.subtitle' => 'The server is being checked.',
			'serverCompatibility.check.success.compatibilityStatus.fullyCompatible.title' => 'Server is compatible',
			'serverCompatibility.check.success.compatibilityStatus.fullyCompatible.subtitle' => 'The server is reachable and compatible.',
			'serverCompatibility.check.success.compatibilityStatus.compatible.title' => 'Server is compatible',
			'serverCompatibility.check.success.compatibilityStatus.compatible.subtitle' => 'A newer app version is available. Updating is recommended to prevent future breakage.',
			'serverCompatibility.check.success.compatibilityStatus.updateClient.title' => 'Update required',
			'serverCompatibility.check.success.compatibilityStatus.updateClient.subtitle' => 'Update the app to continue with this server.',
			'serverCompatibility.check.success.compatibilityStatus.updateServer.title' => 'Update required',
			'serverCompatibility.check.success.compatibilityStatus.updateServer.subtitle' => 'Update the server to continue with this app.',
			'serverCompatibility.check.success.connectionInfo.http.title' => 'Connected over HTTP',
			'serverCompatibility.check.success.connectionInfo.http.subtitle' => 'This connection is not encrypted. HTTPS is recommended to protect data exchanged with the server.',
			'serverCompatibility.check.success.connectionInfo.ipAddress.title' => 'Connected using an IP address',
			'serverCompatibility.check.success.connectionInfo.ipAddress.subtitle' => 'The server\'s IP address may change over time, which can prevent future connections.',
			'serverCompatibility.check.success.connectionInfo.httpAndIpAddress.title' => 'Connected over HTTP using an IP address',
			'serverCompatibility.check.success.connectionInfo.httpAndIpAddress.subtitle' => 'This connection is not encrypted, and the server\'s IP address may change over time, which can prevent future connections.',
			'serverCompatibility.check.success.serverConnectionDetailsTooltip' => ({required Object version, required Object buildNumber, required Object serverUrl}) => 'Server version: ${version}+${buildNumber}\nConnection URL: ${serverUrl}',
			'serverCompatibility.check.failure.title' => 'Compatibility check failed',
			'serverSelection.browserPlatform.useWebAppServer.title' => 'Use this server',
			'serverSelection.browserPlatform.useWebAppServer.subtitle' => 'Connect to the same server that is hosting this application',
			'serverSelection.browserPlatform.useWebAppServer.serverAddressLabel' => 'Server address:',
			'serverSelection.browserPlatform.useWebAppServer.badge' => 'Current Server',
			'serverSelection.browserPlatform.or' => 'or',
			'serverSelection.browserPlatform.manualAddress.title' => 'Use a different server',
			'serverSelection.browserPlatform.manualAddress.subtitle' => 'Provide an external server address',
			'serverSelection.localNetworkDiscovery.button' => 'Find on Network',
			'serverSelection.localNetworkDiscovery.tooltip' => 'Detect servers available on local network',
			'serverSelection.localNetworkDiscovery.refreshServersButton' => 'Refresh',
			'serverSelection.localNetworkDiscovery.serverListTitle' => 'Available Servers',
			'serverSelection.localNetworkDiscovery.discoveredServerPrompt' => 'Select a server found on your local network.',
			'serverSelection.localNetworkDiscovery.discoveredServersCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Found ${n} server', other: 'Found ${n} servers', ), 
			'serverSelection.localNetworkDiscovery.tile.menu.copyIpAddressEndpoint' => 'Copy IP & Port',
			'serverSelection.localNetworkDiscovery.tile.menu.copyLocalHostnameEndpoint' => 'Copy Hostname & Port',
			'serverSelection.localNetworkDiscovery.tile.serverConnectionLatency' => ({required Object latencyMs}) => '${latencyMs} ms',
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
			'serverSelection.manualAddress.textField.validationErrors.unsupportedScheme' => ({required Object scheme}) => 'Unsupported protocol: ${scheme}',
			'serverSelection.manualAddress.textField.validationErrors.missingHost' => 'A host is required',
			'serverSelection.manualAddress.textField.validationErrors.invalidPort' => ({required Object port}) => 'Invalid port: ${port}',
			'serverSelection.manualAddress.textField.hint' => 'e.g., https://example.com',
			'serverSelection.manualAddress.textField.label' => 'Server URL',
			'serverSelection.manualAddress.textField.helper' => 'Enter the URL of the server',
			'serverSelection.manualAddress.textField.infoTooltip' => 'Can be provided by a service administrator or self-hosted.',
			'workInProgress.title' => 'Under Construction!',
			'workInProgress.subtitle' => 'Watch your step! We are still laying down the code for this feature. Check back soon!',
			'settings.locale.title' => 'Language',
			'settings.locale.systemDefault' => 'System',
			'settings.themeMode.title' => 'Theme Mode',
			'settings.themeMode.options.system' => 'System',
			'settings.themeMode.options.dark' => 'Dark',
			'settings.themeMode.options.light' => 'Light',
			'settings.useSystemColors.title' => 'Inherit System Colors',
			'settings.useSystemColors.subtitle' => 'Automatically adapt to the system colors',
			'settings.useCustomAccentColor.title' => 'Custom Accent Color',
			'settings.useCustomAccentColor.subtitle' => 'Customize the accent color of the app theme',
			'settings.useCustomAccentColor.pickColorDialog.title' => 'Pick a Color',
			'settings.useCustomAccentColor.pickColorDialog.close' => 'Close',
			'settings.useAnimatedGraphics.title' => 'Animated Graphics',
			'settings.useAnimatedGraphics.subtitle' => 'Displays animations instead of static icons',
			'settings.sendCrashReports.title' => 'Send Crash Reports',
			'settings.sendCrashReports.subtitle' => ({required Object appName}) => 'Help Improve ${appName} by sending anonymous crash reports',
			'apiRequestFailures.connection' => 'Unable to connect to the server.',
			'apiRequestFailures.unexpected' => 'An unexpected error occurred.',
			'apiRequestFailures.unhandledServerResponse' => 'An unexpected server response occurred.',
			'apiRequestFailures.tooManyRequests' => 'Too many requests. Please try again later.',
			'apiRequestFailures.serviceUnavailable' => 'Server is currently unavailable.',
			'apiRequestFailures.internalServer' => 'Internal server error occurred.',
			'apiRequestFailures.malformedJson' => 'Received malformed data from server.',
			'apiRequestFailures.jsonDeserialization' => 'Failed to parse server response.',
			'apiRequestFailures.unauthorized' => 'Authentication failed. Please sign in again.',
			'apiRequestFailures.accessForbidden' => 'Access denied.',
			'loginFormSection.emailAddressTextField.validationErrors.emptyInput' => 'An email address is required',
			'loginFormSection.emailAddressTextField.validationErrors.invalidEmailAddress' => 'Must be a valid email address',
			'loginFormSection.emailAddressTextField.label' => 'Email address',
			'loginFormSection.emailAddressTextField.hint' => 'you@example.org',
			'loginFormSection.passwordTextField.validationErrors.emptyInput' => 'A password is required',
			'loginFormSection.passwordTextField.validationErrors.invalidLength' => 'Password must be between 8 and 255 characters',
			'loginFormSection.passwordTextField.label' => 'Password',
			'loginFormSection.passwordTextField.visibility.show' => 'Show password',
			'loginFormSection.passwordTextField.visibility.hide' => 'Hide password',
			'loginFormSection.persistAuthSession' => 'Stay signed in',
			'loginFormSection.browserGuestModeNotice.text' => 'Not your device? Use Guest mode to sign in privately.',
			'loginFormSection.browserGuestModeNotice.learnMore' => 'Learn more about using Guest mode',
			'loginFormSection.loginButton' => 'Log in',
			'loginFormSection.loginFailures.invalidCredentials' => 'Invalid email or password.',
			'loginFormSection.loginFailures.loginDisabled' => 'Login is disabled. Contact an administrator to enable it.',
			'loginFormSection.loginFailures.invalidInput' => 'The login input is invalid.',
			'loginFormSection.requestFailureTitle' => 'Login failed',
			'loginFormSection.loginSuccess.title' => 'Login successful',
			'loginFormSection.loginSuccess.subtitle' => ({required Object fullName}) => 'Signed in as ${fullName}',
			'loginFormSection.loginSuccess.logout' => 'Log out',
			'loginFormSection.loginCredentialsGuide.label' => 'How to get login credentials',
			'loginFormSection.loginCredentialsGuide.description' => 'Contact your server administrator to obtain login credentials. The server prompts the administrator to create the first user, who can then create other users.',
			'labSettingsForm.labNameTextField.validationErrors.emptyInput' => 'A lab name is required',
			'labSettingsForm.labNameTextField.label' => 'Lab name',
			'labSettingsForm.labNameTextField.hint' => 'e.g., Central Diagnostic Laboratory',
			'labSettingsForm.updateButton' => 'Update',
			'labSettingsForm.refreshButton' => 'Refresh',
			'labSettingsForm.fetch.loadingMessage' => 'Loading lab information...',
			'labSettingsForm.fetch.failureTitle' => 'Failed to load lab information',
			'labSettingsForm.updateFailureMessage' => 'Failed to update lab information',
			'labSettingsForm.labNameMissingWithoutUpdatePermissionMessage' => 'Lab name is not set. The logged-in user lacks the required permission. Another user with this permission must provide the lab name.',
			'questionMark' => '?',
			'retry' => 'Retry',
			'filePicker.pickFailure' => 'Failed to select the file.',
			'filePicker.exceedsMaximumSize' => ({required Object maxSize}) => 'The selected file exceeds the maximum allowed size of ${maxSize}.',
			'filePicker.readFailure' => 'Failed to read the selected file.',
			'imagePicker.changeImage' => 'Change image',
			'imagePicker.removeImage' => 'Remove image',
			'copyErrorDetails' => 'Copy error details',
			'homePage.destinations.settings.label' => 'Settings',
			'homePage.actions.switchUser' => 'Switch user',
			'homePage.actions.logout' => 'Log out',
			_ => null,
		};
	}
}
