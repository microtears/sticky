library shine;

import 'dart:ui';

// export 'src/progress_indicator.dart' show CircularProgressIndicator;
import 'package:flutter/services.dart';
export 'src/non_overlay_behavior.dart';
export 'src/accent_color_override.dart';
export 'src/bottom_navigation_bar_wrap.dart';

/// Set translate statusbar
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

/// Set fullScreen
void setFullScreen([List<SystemUiOverlay> overlays = const []]) =>
    SystemChrome.setEnabledSystemUIOverlays(overlays);

/// This is a function that which can convert [color] int
/// or [color] string to 'dart:ui/[Color]',And this is
/// the [color] example: '#fff','#ffffff','#ffffffff'
/// or hex number such as '0xFF111111'.
/// The format must be R->G->B.
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
