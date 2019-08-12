import 'package:flutter/material.dart';

class NonOverlayBehavior extends ScrollBehavior {
  static const nonOverlayBehavior = NonOverlayBehavior();

  const NonOverlayBehavior();

  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
