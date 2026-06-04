// Similar to Flutter's `foundation/constants.dart` but
// with minimal required functionality.
// https://github.com/dart-lang/sdk/issues/31992#issuecomment-4610611205

const bool _kReleaseMode = bool.fromEnvironment('dart.vm.product');
const bool _kProfileMode = bool.fromEnvironment('dart.vm.profile');
const bool kDebugMode = !_kReleaseMode && !_kProfileMode;
