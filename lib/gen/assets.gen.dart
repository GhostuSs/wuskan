/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/activebtnpurple.png
  AssetGenImage get activebtnpurplePng =>
      const AssetGenImage('assets/images/activebtnpurple.png');

  /// File path: assets/images/activebtnpurple.svg
  SvgGenImage get activebtnpurpleSvg =>
      const SvgGenImage('assets/images/activebtnpurple.svg');

  /// File path: assets/images/bg1.png
  AssetGenImage get bg1 => const AssetGenImage('assets/images/bg1.png');

  /// File path: assets/images/bg2.png
  AssetGenImage get bg2 => const AssetGenImage('assets/images/bg2.png');

  /// File path: assets/images/bg3.png
  AssetGenImage get bg3 => const AssetGenImage('assets/images/bg3.png');

  /// File path: assets/images/bomb.png
  AssetGenImage get bomb => const AssetGenImage('assets/images/bomb.png');

  /// File path: assets/images/coin.png
  AssetGenImage get coin => const AssetGenImage('assets/images/coin.png');

  /// File path: assets/images/inactivebtngray.svg
  SvgGenImage get inactivebtngray =>
      const SvgGenImage('assets/images/inactivebtngray.svg');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/longbtnnlue.svg
  SvgGenImage get longbtnnlue =>
      const SvgGenImage('assets/images/longbtnnlue.svg');

  /// File path: assets/images/lose.png
  AssetGenImage get lose => const AssetGenImage('assets/images/lose.png');

  /// File path: assets/images/onboardingbtn.svg
  SvgGenImage get onboardingbtn =>
      const SvgGenImage('assets/images/onboardingbtn.svg');

  /// File path: assets/images/player 1.png
  AssetGenImage get player1 =>
      const AssetGenImage('assets/images/player 1.png');

  /// File path: assets/images/player 2.png
  AssetGenImage get player2 =>
      const AssetGenImage('assets/images/player 2.png');

  /// File path: assets/images/player 3.png
  AssetGenImage get player3 =>
      const AssetGenImage('assets/images/player 3.png');

  /// File path: assets/images/player 4.png
  AssetGenImage get player4 =>
      const AssetGenImage('assets/images/player 4.png');

  /// File path: assets/images/player 5.png
  AssetGenImage get player5 =>
      const AssetGenImage('assets/images/player 5.png');

  /// File path: assets/images/polygon.svg
  SvgGenImage get polygon => const SvgGenImage('assets/images/polygon.svg');

  /// File path: assets/images/shortbtnblue.svg
  SvgGenImage get shortbtnblue =>
      const SvgGenImage('assets/images/shortbtnblue.svg');

  /// File path: assets/images/win.png
  AssetGenImage get win => const AssetGenImage('assets/images/win.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;
}
