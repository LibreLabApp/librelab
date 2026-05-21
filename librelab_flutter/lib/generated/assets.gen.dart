// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart' as _lottie;

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/account.json
  LottieGenImage get account =>
      const LottieGenImage('assets/lottie/account.json');

  /// File path: assets/lottie/empty_result.json
  LottieGenImage get emptyResult =>
      const LottieGenImage('assets/lottie/empty_result.json');

  /// File path: assets/lottie/radar.json
  LottieGenImage get radar => const LottieGenImage('assets/lottie/radar.json');

  /// File path: assets/lottie/rocket.json
  LottieGenImage get rocket =>
      const LottieGenImage('assets/lottie/rocket.json');

  /// File path: assets/lottie/server.json
  LottieGenImage get server =>
      const LottieGenImage('assets/lottie/server.json');

  /// File path: assets/lottie/settings.json
  LottieGenImage get settings =>
      const LottieGenImage('assets/lottie/settings.json');

  /// File path: assets/lottie/under_construction.json
  LottieGenImage get underConstruction =>
      const LottieGenImage('assets/lottie/under_construction.json');

  /// List of all assets
  List<LottieGenImage> get values => [
    account,
    emptyResult,
    radar,
    rocket,
    server,
    settings,
    underConstruction,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class LottieGenImage {
  const LottieGenImage(this._assetName, {this.flavors = const {}});

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, _lottie.LottieComposition?)?
    frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
    _lottie.LottieDecoder? decoder,
    _lottie.RenderCache? renderCache,
    bool? backgroundLoading,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
      decoder: decoder,
      renderCache: renderCache,
      backgroundLoading: backgroundLoading,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
