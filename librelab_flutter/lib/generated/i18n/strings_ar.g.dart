///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$initialSetupPage$ar initialSetupPage = _Translations$initialSetupPage$ar._(_root);
	@override late final _Translations$confirmProgramExitDialog$ar confirmProgramExitDialog = _Translations$confirmProgramExitDialog$ar._(_root);
	@override late final _Translations$serverHandshake$ar serverHandshake = _Translations$serverHandshake$ar._(_root);
	@override late final _Translations$serverSelection$ar serverSelection = _Translations$serverSelection$ar._(_root);
	@override late final _Translations$workInProgress$ar workInProgress = _Translations$workInProgress$ar._(_root);
	@override late final _Translations$settings$ar settings = _Translations$settings$ar._(_root);
}

// Path: initialSetupPage
class _Translations$initialSetupPage$ar extends Translations$initialSetupPage$en {
	_Translations$initialSetupPage$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإعداد الأولي';
	@override late final _Translations$initialSetupPage$steps$ar steps = _Translations$initialSetupPage$steps$ar._(_root);
	@override String get next => 'التالي';
	@override String get back => 'السابق';
	@override late final _Translations$initialSetupPage$decorativeAnimation$ar decorativeAnimation = _Translations$initialSetupPage$decorativeAnimation$ar._(_root);
}

// Path: confirmProgramExitDialog
class _Translations$confirmProgramExitDialog$ar extends Translations$confirmProgramExitDialog$en {
	_Translations$confirmProgramExitDialog$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تأكيد الخروج';
	@override String get message => 'هل أنت متأكد من رغبتك في الخروج؟ قد تفقد أي تغييرات غير محفوظة.';
	@override String get backupCheckbox => 'نسخ البيانات احتياطيا قبل الإغلاق';
	@override String get cancelButton => 'إلغاء';
	@override String get confirmButton => 'خروج';
}

// Path: serverHandshake
class _Translations$serverHandshake$ar extends Translations$serverHandshake$en {
	_Translations$serverHandshake$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختبار الاتصال';
	@override String get subtitle => 'تأكد من إمكانية الاتصال بالخادم قبل المتابعة.';
	@override String get button => 'اختبار الاتصال';
}

// Path: serverSelection
class _Translations$serverSelection$ar extends Translations$serverSelection$en {
	_Translations$serverSelection$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$serverSelection$localNetworkDiscovery$ar localNetworkDiscovery = _Translations$serverSelection$localNetworkDiscovery$ar._(_root);
	@override late final _Translations$serverSelection$manualAddress$ar manualAddress = _Translations$serverSelection$manualAddress$ar._(_root);
}

// Path: workInProgress
class _Translations$workInProgress$ar extends Translations$workInProgress$en {
	_Translations$workInProgress$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'قيد التطوير';
	@override String get subtitle => 'هذه الميزة لا تزال قيد التطوير وستتوفر قريبا.';
}

// Path: settings
class _Translations$settings$ar extends Translations$settings$en {
	_Translations$settings$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$locale$ar locale = _Translations$settings$locale$ar._(_root);
	@override late final _Translations$settings$themeMode$ar themeMode = _Translations$settings$themeMode$ar._(_root);
	@override late final _Translations$settings$useSystemColors$ar useSystemColors = _Translations$settings$useSystemColors$ar._(_root);
	@override late final _Translations$settings$useCustomAccentColor$ar useCustomAccentColor = _Translations$settings$useCustomAccentColor$ar._(_root);
	@override late final _Translations$settings$sendCrashReports$ar sendCrashReports = _Translations$settings$sendCrashReports$ar._(_root);
}

// Path: initialSetupPage.steps
class _Translations$initialSetupPage$steps$ar extends Translations$initialSetupPage$steps$en {
	_Translations$initialSetupPage$steps$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$initialSetupPage$steps$preferences$ar preferences = _Translations$initialSetupPage$steps$preferences$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$server$ar server = _Translations$initialSetupPage$steps$server$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$account$ar account = _Translations$initialSetupPage$steps$account$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$complete$ar complete = _Translations$initialSetupPage$steps$complete$ar._(_root);
}

// Path: initialSetupPage.decorativeAnimation
class _Translations$initialSetupPage$decorativeAnimation$ar extends Translations$initialSetupPage$decorativeAnimation$en {
	_Translations$initialSetupPage$decorativeAnimation$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'أوشكنا على الانتهاء!';
	@override String get subtitle => 'لنكمل إعداد التطبيق';
}

// Path: serverSelection.localNetworkDiscovery
class _Translations$serverSelection$localNetworkDiscovery$ar extends Translations$serverSelection$localNetworkDiscovery$en {
	_Translations$serverSelection$localNetworkDiscovery$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get button => 'البحث في الشبكة';
	@override String get tooltip => 'البحث عن الخوادم المتوفرة على الشبكة المحلية';
	@override String get refreshServersButton => 'تحديث';
	@override String get serverListTitle => 'الخوادم المتوفرة';
	@override String get discoveredServerPrompt => 'اختر خادما تم العثور عليه على الشبكة المحلية.';
	@override String discoveredServersCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n,
		one: 'تم العثور على خادم واحد',
		other: 'تم العثور على ${n} خوادم',
	);
	@override late final _Translations$serverSelection$localNetworkDiscovery$tileMenu$ar tileMenu = _Translations$serverSelection$localNetworkDiscovery$tileMenu$ar._(_root);
	@override late final _Translations$serverSelection$localNetworkDiscovery$noServersFound$ar noServersFound = _Translations$serverSelection$localNetworkDiscovery$noServersFound$ar._(_root);
}

// Path: serverSelection.manualAddress
class _Translations$serverSelection$manualAddress$ar extends Translations$serverSelection$manualAddress$en {
	_Translations$serverSelection$manualAddress$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get button => 'إدخال عنوان الخادم';
	@override String get tooltip => 'إدخال عنوان الخادم يدويا';
	@override late final _Translations$serverSelection$manualAddress$textField$ar textField = _Translations$serverSelection$manualAddress$textField$ar._(_root);
}

// Path: settings.locale
class _Translations$settings$locale$ar extends Translations$settings$locale$en {
	_Translations$settings$locale$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لغة التطبيق';
	@override String get subtitle => 'اختر لغتك المفضلة';
	@override String get systemDefault => 'لغة النظام';
}

// Path: settings.themeMode
class _Translations$settings$themeMode$ar extends Translations$settings$themeMode$en {
	_Translations$settings$themeMode$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'المظهر';
	@override String get subtitle => 'اختر مظهر التطبيق';
	@override late final _Translations$settings$themeMode$options$ar options = _Translations$settings$themeMode$options$ar._(_root);
}

// Path: settings.useSystemColors
class _Translations$settings$useSystemColors$ar extends Translations$settings$useSystemColors$en {
	_Translations$settings$useSystemColors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'استخدام الوان النظام';
	@override String get subtitle => 'التكيف تلقائيا مع الوان النظام';
}

// Path: settings.useCustomAccentColor
class _Translations$settings$useCustomAccentColor$ar extends Translations$settings$useCustomAccentColor$en {
	_Translations$settings$useCustomAccentColor$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لون مميز مخصص';
	@override String get subtitle => 'تخصيص لون التمييز للتطبيق';
	@override late final _Translations$settings$useCustomAccentColor$pickColorDialog$ar pickColorDialog = _Translations$settings$useCustomAccentColor$pickColorDialog$ar._(_root);
}

// Path: settings.sendCrashReports
class _Translations$settings$sendCrashReports$ar extends Translations$settings$sendCrashReports$en {
	_Translations$settings$sendCrashReports$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إرسال تقارير الأعطال';
	@override String subtitle({required Object appName}) => 'المساعدة في تحسين ${appName} بإرسال تقارير أعطال مجهولة الهوية';
}

// Path: initialSetupPage.steps.preferences
class _Translations$initialSetupPage$steps$preferences$ar extends Translations$initialSetupPage$steps$preferences$en {
	_Translations$initialSetupPage$steps$preferences$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$initialSetupPage$steps$preferences$nav$ar nav = _Translations$initialSetupPage$steps$preferences$nav$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$preferences$content$ar content = _Translations$initialSetupPage$steps$preferences$content$ar._(_root);
}

// Path: initialSetupPage.steps.server
class _Translations$initialSetupPage$steps$server$ar extends Translations$initialSetupPage$steps$server$en {
	_Translations$initialSetupPage$steps$server$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$initialSetupPage$steps$server$nav$ar nav = _Translations$initialSetupPage$steps$server$nav$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$server$content$ar content = _Translations$initialSetupPage$steps$server$content$ar._(_root);
}

// Path: initialSetupPage.steps.account
class _Translations$initialSetupPage$steps$account$ar extends Translations$initialSetupPage$steps$account$en {
	_Translations$initialSetupPage$steps$account$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$initialSetupPage$steps$account$nav$ar nav = _Translations$initialSetupPage$steps$account$nav$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$account$content$ar content = _Translations$initialSetupPage$steps$account$content$ar._(_root);
}

// Path: initialSetupPage.steps.complete
class _Translations$initialSetupPage$steps$complete$ar extends Translations$initialSetupPage$steps$complete$en {
	_Translations$initialSetupPage$steps$complete$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$initialSetupPage$steps$complete$nav$ar nav = _Translations$initialSetupPage$steps$complete$nav$ar._(_root);
	@override late final _Translations$initialSetupPage$steps$complete$content$ar content = _Translations$initialSetupPage$steps$complete$content$ar._(_root);
}

// Path: serverSelection.localNetworkDiscovery.tileMenu
class _Translations$serverSelection$localNetworkDiscovery$tileMenu$ar extends Translations$serverSelection$localNetworkDiscovery$tileMenu$en {
	_Translations$serverSelection$localNetworkDiscovery$tileMenu$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get copyIpAddressEndpoint => 'نسخ عنوان IP والمنفذ';
	@override String get copyLocalHostnameEndpoint => 'نسخ اسم المضيف والمنفذ';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound
class _Translations$serverSelection$localNetworkDiscovery$noServersFound$ar extends Translations$serverSelection$localNetworkDiscovery$noServersFound$en {
	_Translations$serverSelection$localNetworkDiscovery$noServersFound$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$ar doneScanning = _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$ar._(_root);
	@override late final _Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$ar stillScanning = _Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$ar._(_root);
}

// Path: serverSelection.manualAddress.textField
class _Translations$serverSelection$manualAddress$textField$ar extends Translations$serverSelection$manualAddress$textField$en {
	_Translations$serverSelection$manualAddress$textField$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$serverSelection$manualAddress$textField$validationErrors$ar validationErrors = _Translations$serverSelection$manualAddress$textField$validationErrors$ar._(_root);
	@override String get hint => 'مثال: https://example.com';
	@override String get label => 'عنوان الخادم';
	@override String get helper => 'أدخل عنوان URL الخاص بالخادم';
	@override String get infoTooltip => 'يمكن الحصول عليه من مسؤول الخدمة أو من خادم مستضاف ذاتيا.';
}

// Path: settings.themeMode.options
class _Translations$settings$themeMode$options$ar extends Translations$settings$themeMode$options$en {
	_Translations$settings$themeMode$options$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get system => 'النظام';
	@override String get dark => 'داكن';
	@override String get light => 'فاتح';
}

// Path: settings.useCustomAccentColor.pickColorDialog
class _Translations$settings$useCustomAccentColor$pickColorDialog$ar extends Translations$settings$useCustomAccentColor$pickColorDialog$en {
	_Translations$settings$useCustomAccentColor$pickColorDialog$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر لونًا';
	@override String get close => 'إغلاق';
}

// Path: initialSetupPage.steps.preferences.nav
class _Translations$initialSetupPage$steps$preferences$nav$ar extends Translations$initialSetupPage$steps$preferences$nav$en {
	_Translations$initialSetupPage$steps$preferences$nav$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التفضيلات';
	@override String get subtitle => 'اختر تفضيلاتك';
}

// Path: initialSetupPage.steps.preferences.content
class _Translations$initialSetupPage$steps$preferences$content$ar extends Translations$initialSetupPage$steps$preferences$content$en {
	_Translations$initialSetupPage$steps$preferences$content$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التخصيص';
	@override String get subtitle => 'اضبط المظهر واللغة وخيارات الواجهة';
}

// Path: initialSetupPage.steps.server.nav
class _Translations$initialSetupPage$steps$server$nav$ar extends Translations$initialSetupPage$steps$server$nav$en {
	_Translations$initialSetupPage$steps$server$nav$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الخادم';
	@override String get subtitle => 'إعداد الاتصال بالخادم';
	@override String get prerequisiteStepIncomplete => 'يرجى اختيار خادم واختبار الاتصال أولا';
}

// Path: initialSetupPage.steps.server.content
class _Translations$initialSetupPage$steps$server$content$ar extends Translations$initialSetupPage$steps$server$content$en {
	_Translations$initialSetupPage$steps$server$content$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الاتصال بالخادم';
	@override String get subtitle => 'اتصل بخادم للوصول إلى بياناتك ومزامنتها';
}

// Path: initialSetupPage.steps.account.nav
class _Translations$initialSetupPage$steps$account$nav$ar extends Translations$initialSetupPage$steps$account$nav$en {
	_Translations$initialSetupPage$steps$account$nav$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الحساب';
	@override String get subtitle => 'سجل الدخول باستخدام بياناتك';
	@override String get prerequisiteStepIncomplete => 'أكمل إعداد الحساب أولا';
}

// Path: initialSetupPage.steps.account.content
class _Translations$initialSetupPage$steps$account$content$ar extends Translations$initialSetupPage$steps$account$content$en {
	_Translations$initialSetupPage$steps$account$content$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'تسجيل الدخول';
	@override String get subtitle => 'سجل الدخول لمتابعة الإعداد';
}

// Path: initialSetupPage.steps.complete.nav
class _Translations$initialSetupPage$steps$complete$nav$ar extends Translations$initialSetupPage$steps$complete$nav$en {
	_Translations$initialSetupPage$steps$complete$nav$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اكتمل';
	@override String get subtitle => 'إنهاء الإعداد';
}

// Path: initialSetupPage.steps.complete.content
class _Translations$initialSetupPage$steps$complete$content$ar extends Translations$initialSetupPage$steps$complete$content$en {
	_Translations$initialSetupPage$steps$complete$content$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كل شيء جاهز!';
	@override String get subtitle => 'اكتمل إعداد التطبيق';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning
class _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$ar extends Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$en {
	_Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لم يتم العثور على خوادم';
	@override String subtitle({required Object appName}) => 'تم فحص الشبكة المحلية، ولكن لم يتم العثور على أي خوادم ${appName}.';
	@override late final _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$ar troubleshootingTips = _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$ar._(_root);
	@override late final _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$ar hostServerGuideButton = _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$ar._(_root);
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.stillScanning
class _Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$ar extends Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$en {
	_Translations$serverSelection$localNetworkDiscovery$noServersFound$stillScanning$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جار فحص الشبكة...';
	@override String subtitle({required Object appName}) => 'يتم البحث عن خوادم ${appName} على الشبكة المحلية. قد يستغرق ذلك بضع لحظات.';
}

// Path: serverSelection.manualAddress.textField.validationErrors
class _Translations$serverSelection$manualAddress$textField$validationErrors$ar extends Translations$serverSelection$manualAddress$textField$validationErrors$en {
	_Translations$serverSelection$manualAddress$textField$validationErrors$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get emptyInput => 'عنوان الخادم مطلوب';
	@override String get invalidUri => 'يجب إدخال عنوان URL صالح';
	@override String get missingScheme => 'البروتوكول مطلوب (مثل https://)';
	@override String unsupportedScheme({required Object scheme}) => 'بروتوكول غير مدعوم: ${scheme}';
	@override String get missingHost => 'اسم المضيف مطلوب';
	@override String invalidPort({required Object port}) => 'منفذ غير صالح: ${port}';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips
class _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$ar extends Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$en {
	_Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$troubleshootingTips$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جرب ما يلي:';
	@override String get toggleButtonLabel => 'استكشاف الأخطاء';
	@override String get serverNotRunning => 'تأكد من أن الخادم قيد التشغيل';
	@override String get sameNetwork => 'تأكد من اتصال الجهاز والخادم بالشبكة نفسها';
	@override String get refreshList => 'حدث القائمة ثم أعد المحاولة';
	@override String get manualEntry => 'أو أدخل عنوان الخادم يدويا';
}

// Path: serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton
class _Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$ar extends Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$en {
	_Translations$serverSelection$localNetworkDiscovery$noServersFound$doneScanning$hostServerGuideButton$ar._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get tooltip => 'تعرف على كيفية إعداد واستضافة خادم';
	@override String get label => 'كيفية استضافة خادم';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'initialSetupPage.title' => 'الإعداد الأولي',
			'initialSetupPage.steps.preferences.nav.title' => 'التفضيلات',
			'initialSetupPage.steps.preferences.nav.subtitle' => 'اختر تفضيلاتك',
			'initialSetupPage.steps.preferences.content.title' => 'التخصيص',
			'initialSetupPage.steps.preferences.content.subtitle' => 'اضبط المظهر واللغة وخيارات الواجهة',
			'initialSetupPage.steps.server.nav.title' => 'الخادم',
			'initialSetupPage.steps.server.nav.subtitle' => 'إعداد الاتصال بالخادم',
			'initialSetupPage.steps.server.nav.prerequisiteStepIncomplete' => 'يرجى اختيار خادم واختبار الاتصال أولا',
			'initialSetupPage.steps.server.content.title' => 'الاتصال بالخادم',
			'initialSetupPage.steps.server.content.subtitle' => 'اتصل بخادم للوصول إلى بياناتك ومزامنتها',
			'initialSetupPage.steps.account.nav.title' => 'الحساب',
			'initialSetupPage.steps.account.nav.subtitle' => 'سجل الدخول باستخدام بياناتك',
			'initialSetupPage.steps.account.nav.prerequisiteStepIncomplete' => 'أكمل إعداد الحساب أولا',
			'initialSetupPage.steps.account.content.title' => 'تسجيل الدخول',
			'initialSetupPage.steps.account.content.subtitle' => 'سجل الدخول لمتابعة الإعداد',
			'initialSetupPage.steps.complete.nav.title' => 'اكتمل',
			'initialSetupPage.steps.complete.nav.subtitle' => 'إنهاء الإعداد',
			'initialSetupPage.steps.complete.content.title' => 'كل شيء جاهز!',
			'initialSetupPage.steps.complete.content.subtitle' => 'اكتمل إعداد التطبيق',
			'initialSetupPage.next' => 'التالي',
			'initialSetupPage.back' => 'السابق',
			'initialSetupPage.decorativeAnimation.title' => 'أوشكنا على الانتهاء!',
			'initialSetupPage.decorativeAnimation.subtitle' => 'لنكمل إعداد التطبيق',
			'confirmProgramExitDialog.title' => 'تأكيد الخروج',
			'confirmProgramExitDialog.message' => 'هل أنت متأكد من رغبتك في الخروج؟ قد تفقد أي تغييرات غير محفوظة.',
			'confirmProgramExitDialog.backupCheckbox' => 'نسخ البيانات احتياطيا قبل الإغلاق',
			'confirmProgramExitDialog.cancelButton' => 'إلغاء',
			'confirmProgramExitDialog.confirmButton' => 'خروج',
			'serverHandshake.title' => 'اختبار الاتصال',
			'serverHandshake.subtitle' => 'تأكد من إمكانية الاتصال بالخادم قبل المتابعة.',
			'serverHandshake.button' => 'اختبار الاتصال',
			'serverSelection.localNetworkDiscovery.button' => 'البحث في الشبكة',
			'serverSelection.localNetworkDiscovery.tooltip' => 'البحث عن الخوادم المتوفرة على الشبكة المحلية',
			'serverSelection.localNetworkDiscovery.refreshServersButton' => 'تحديث',
			'serverSelection.localNetworkDiscovery.serverListTitle' => 'الخوادم المتوفرة',
			'serverSelection.localNetworkDiscovery.discoveredServerPrompt' => 'اختر خادما تم العثور عليه على الشبكة المحلية.',
			'serverSelection.localNetworkDiscovery.discoveredServersCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ar'))(n, one: 'تم العثور على خادم واحد', other: 'تم العثور على ${n} خوادم', ), 
			'serverSelection.localNetworkDiscovery.tileMenu.copyIpAddressEndpoint' => 'نسخ عنوان IP والمنفذ',
			'serverSelection.localNetworkDiscovery.tileMenu.copyLocalHostnameEndpoint' => 'نسخ اسم المضيف والمنفذ',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.title' => 'لم يتم العثور على خوادم',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.subtitle' => ({required Object appName}) => 'تم فحص الشبكة المحلية، ولكن لم يتم العثور على أي خوادم ${appName}.',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.title' => 'جرب ما يلي:',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.toggleButtonLabel' => 'استكشاف الأخطاء',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.serverNotRunning' => 'تأكد من أن الخادم قيد التشغيل',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.sameNetwork' => 'تأكد من اتصال الجهاز والخادم بالشبكة نفسها',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.refreshList' => 'حدث القائمة ثم أعد المحاولة',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.troubleshootingTips.manualEntry' => 'أو أدخل عنوان الخادم يدويا',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.tooltip' => 'تعرف على كيفية إعداد واستضافة خادم',
			'serverSelection.localNetworkDiscovery.noServersFound.doneScanning.hostServerGuideButton.label' => 'كيفية استضافة خادم',
			'serverSelection.localNetworkDiscovery.noServersFound.stillScanning.title' => 'جار فحص الشبكة...',
			'serverSelection.localNetworkDiscovery.noServersFound.stillScanning.subtitle' => ({required Object appName}) => 'يتم البحث عن خوادم ${appName} على الشبكة المحلية. قد يستغرق ذلك بضع لحظات.',
			'serverSelection.manualAddress.button' => 'إدخال عنوان الخادم',
			'serverSelection.manualAddress.tooltip' => 'إدخال عنوان الخادم يدويا',
			'serverSelection.manualAddress.textField.validationErrors.emptyInput' => 'عنوان الخادم مطلوب',
			'serverSelection.manualAddress.textField.validationErrors.invalidUri' => 'يجب إدخال عنوان URL صالح',
			'serverSelection.manualAddress.textField.validationErrors.missingScheme' => 'البروتوكول مطلوب (مثل https://)',
			'serverSelection.manualAddress.textField.validationErrors.unsupportedScheme' => ({required Object scheme}) => 'بروتوكول غير مدعوم: ${scheme}',
			'serverSelection.manualAddress.textField.validationErrors.missingHost' => 'اسم المضيف مطلوب',
			'serverSelection.manualAddress.textField.validationErrors.invalidPort' => ({required Object port}) => 'منفذ غير صالح: ${port}',
			'serverSelection.manualAddress.textField.hint' => 'مثال: https://example.com',
			'serverSelection.manualAddress.textField.label' => 'عنوان الخادم',
			'serverSelection.manualAddress.textField.helper' => 'أدخل عنوان URL الخاص بالخادم',
			'serverSelection.manualAddress.textField.infoTooltip' => 'يمكن الحصول عليه من مسؤول الخدمة أو من خادم مستضاف ذاتيا.',
			'workInProgress.title' => 'قيد التطوير',
			'workInProgress.subtitle' => 'هذه الميزة لا تزال قيد التطوير وستتوفر قريبا.',
			'settings.locale.title' => 'لغة التطبيق',
			'settings.locale.subtitle' => 'اختر لغتك المفضلة',
			'settings.locale.systemDefault' => 'لغة النظام',
			'settings.themeMode.title' => 'المظهر',
			'settings.themeMode.subtitle' => 'اختر مظهر التطبيق',
			'settings.themeMode.options.system' => 'النظام',
			'settings.themeMode.options.dark' => 'داكن',
			'settings.themeMode.options.light' => 'فاتح',
			'settings.useSystemColors.title' => 'استخدام الوان النظام',
			'settings.useSystemColors.subtitle' => 'التكيف تلقائيا مع الوان النظام',
			'settings.useCustomAccentColor.title' => 'لون مميز مخصص',
			'settings.useCustomAccentColor.subtitle' => 'تخصيص لون التمييز للتطبيق',
			'settings.useCustomAccentColor.pickColorDialog.title' => 'اختر لونًا',
			'settings.useCustomAccentColor.pickColorDialog.close' => 'إغلاق',
			'settings.sendCrashReports.title' => 'إرسال تقارير الأعطال',
			'settings.sendCrashReports.subtitle' => ({required Object appName}) => 'المساعدة في تحسين ${appName} بإرسال تقارير أعطال مجهولة الهوية',
			_ => null,
		};
	}
}
