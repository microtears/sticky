import 'package:flutter/material.dart';
import 'package:shine/shine.dart';
import 'dart:math' show pi;

class StickyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = hexColor("#4e53f7");
    return SizedBox(
      height: 56,
      width: 56,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
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
          Center(
            child: Text(
              "S",
              // style: TextStyle(color: Colors.white, fontSize: 24),
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.white, fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}
