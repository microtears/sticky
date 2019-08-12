import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StickySnackBar extends SnackBar {
  const StickySnackBar({
    Key key,
    @required Widget content,
    Color backgroundColor = Colors.black,
    double elevation = 0,
    ShapeBorder shape,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction action,
    Duration duration = const Duration(milliseconds: 4000),
    Animation<double> animation,
  }) : super(
          key: key,
          content: content,
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: shape,
          behavior: behavior,
          action: action,
          duration: duration,
          animation: animation,
        );
}
