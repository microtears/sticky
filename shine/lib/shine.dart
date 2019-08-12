library shine;

import 'dart:ui';

import 'package:flutter/services.dart';
export 'src/non_overlay_behavior.dart';
export 'src/accent_color_override.dart';

/// set translate statusbar
void setTranslateStatusBar([
  SystemUiOverlayStyle style = SystemUiOverlayStyle.dark,
  Color color = const Color(0x00000000),
]) {
  SystemChrome.setSystemUIOverlayStyle(
    style.copyWith(
      statusBarColor: color,
    ),
  );
}

/// set fullScreen
void setFullScreen([List<SystemUiOverlay> overlays = const []]) =>
    SystemChrome.setEnabledSystemUIOverlays(overlays);
