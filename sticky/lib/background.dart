import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sticky/data/theme.dart';

class Background extends StatelessWidget {
  final Widget child;
  final double blurRadius;
  final Color opacity;

  final List<Widget> blurAreas;
  const Background({
    Key key,
    this.child,
    this.blurRadius = 0.0,
    this.opacity = Colors.white,
    this.blurAreas = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme =
        StickyTheme.of(context) ?? ThemeController.of(context).stickyTheme;
    final image = theme?.backgroundImage;
    return Container(
      child: Stack(
        fit: StackFit.expand,
        textDirection: TextDirection.ltr,
        children: <Widget>[
          if (image != null) ...[
            if (image.isScheme("asset")) Image.asset(image.path),
            if (image.isScheme("file")) Image.file(File(image.toFilePath())),
            if (image.isScheme("http") || image.isScheme("https"))
              CachedNetworkImage(
                imageUrl: image.toString(),
                fit: BoxFit.cover,
              ),
          ],
          if (blurAreas.isEmpty)
            BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: blurRadius,
                sigmaY: blurRadius,
              ),
              child: Container(color: opacity),
            ),
          ...blurAreas,
          Positioned.fill(child: Opacity(opacity: 0.8, child: child)),
        ],
      ),
    );
  }
}
