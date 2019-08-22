import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shine/shine.dart';

class StickyLogo extends StatefulWidget {
  final StickyLogoController controller;

  const StickyLogo({Key key, this.controller}) : super(key: key);

  @override
  _StickyLogoState createState() => _StickyLogoState();
}

class _StickyLogoState extends State<StickyLogo>
    with SingleTickerProviderStateMixin {
  StickyLogoController _controller;
  AnimationController _anim;
  final Animatable<double> _kRotationTween = Tween(
    begin: 0.0,
    end: math.pi * 2,
  ).chain(CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ));

  @override
  void initState() {
    super.initState();

    _anim = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    _controller = widget.controller ?? StickyLogoController();

    if (_controller.isLoading) {
      _anim.repeat();
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void updateAnimation() {
    if (_controller.isLoading) {
      _anim.repeat();
    } else {
      _anim.animateTo(math.pi * 2).whenComplete(() {
        _anim..stop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = hexColor("#4e53f7");
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, value, child) {
        updateAnimation();
        return buildLogo(context, color);
      },
    );
  }

  GestureDetector buildLogo(BuildContext context, Color color) {
    return GestureDetector(
      onTap: () {
        _controller.isLoading = !_controller.isLoading;
      },
      child: SizedBox(
        height: 56,
        width: 56,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            _controller.isLoading
                ? Padding(
                    padding: EdgeInsets.all(2),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  )
                : Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
            Container(
              margin: EdgeInsets.all(2),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            Transform.rotate(
              angle: _kRotationTween.evaluate(_anim),
              child: Center(
                child: Text(
                  "S",
                  style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StickLogoValue {
  bool _isLoading = false;
}

class StickyLogoController extends ValueNotifier<StickLogoValue> {
  StickyLogoController() : super(StickLogoValue());

  bool get isLoading => value._isLoading;

  set isLoading(bool isLoading) {
    value._isLoading = isLoading;
    notifyListeners();
  }
}
