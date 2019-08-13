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

/// TODO(microtears) add comment.
Color hexColor(color) {
  if (color is int) {
    return Color(color);
  } else {
    assert(color is String && color.indexOf("#") == 0);
    final colorString = color as String;
    final hex = colorString.substring(1);
    if (hex.length == 3) {
      final value = int.parse(hex, radix: 16);
      final r = value ~/ 100;
      final g = (value % 100) ~/ 10;
      final b = (value % 100) % 10;
      return Color.fromARGB(255, r, g, b);
    } else if (hex.length == 6) {
      return Color(int.parse(hex, radix: 16) + 0xFF000000);
    } else if (hex.length == 8) {
      return Color(int.parse(hex, radix: 16));
    } else {
      throw ArgumentError.value(color, "color");
    }
  }
}
