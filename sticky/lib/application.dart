import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:shine/shine.dart';
import 'package:sticky/application.route.dart' as route;
import 'package:sticky/data/theme.dart';
import 'package:sticky/data/user.dart';

@Router()
class Application extends StatelessWidget {
  final _providers = <SingleChildCloneableWidget>[
    ChangeNotifierProvider.value(value: ThemeController()),
    ChangeNotifierProvider.value(value: UserInfo()),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: StickyTheme(
        child: MaterialApp(
          initialRoute: "/",
          debugShowCheckedModeBanner: true,
          onGenerateRoute: route.onGenerateRoute,
          builder: buildChild,
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context, Widget child) {
    // TODO(microtears) Why the following expression always return
    // false?
    if (child is ScrollView) {
      log("$child is scrollview");
      return ScrollConfiguration(
        child: child,
        behavior: NonOverlayBehavior.nonOverlayBehavior,
      );
    } else {
      return ScrollConfiguration(
        child: child,
        behavior: NonOverlayBehavior.nonOverlayBehavior,
      );
    }
  }
}
