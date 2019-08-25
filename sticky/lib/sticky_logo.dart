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

  VoidCallback listener;

  final Animatable<double> _kRotationTween = Tween(
    begin: 0.0,
    end: math.pi * 2,
  ).chain(CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ));

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    _anim = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..addListener(listener);

    _controller = widget.controller ?? StickyLogoController();

    if (_controller.isLoading) {
      _anim.repeat();
    }
  }

  @override
  void didUpdateWidget(StickyLogo oldWidget) {
    oldWidget.controller?.removeListener(listener);
    final newController = widget.controller ?? StickyLogoController();
    if (newController != _controller) {
      _controller.removeListener(listener);
      _controller = newController;
      _controller.addListener(listener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _anim.dispose();
    _controller.removeListener(listener);
    if (widget.controller == null) {
      _controller.dispose();
    }
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
                    padding: const EdgeInsets.all(2),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                    ),
                  )
                : Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
            Container(
              margin: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(5),
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
