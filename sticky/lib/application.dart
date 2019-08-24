import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:shine/shine.dart';
import 'package:sticky/application.route.dart' as route;
import 'package:sticky/background.dart';
import 'package:sticky/data/theme.dart';
import 'package:sticky/data/user.dart';
import 'package:zefyr/zefyr.dart';

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
      child: Consumer<ThemeController>(
        builder: (context, controller, child) =>
            AnnotatedRegion<SystemUiOverlayStyle>(
          value: (controller.theme.brightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light)
              .copyWith(
                  statusBarColor:
                      controller.stickyTheme.backgroundColor.withOpacity(0.0)),
          child: ZefyrTheme(
            data: controller.stickyTheme.zefyrThemeData,
            child: Background(
              blurRadius: 10,
              opacity: controller.theme.brightness == Brightness.dark
                  ? controller.theme.backgroundColor.withOpacity(0.2)
                  : controller.theme.backgroundColor.withOpacity(1),
              child: MaterialApp(
                initialRoute: "/",
                debugShowCheckedModeBanner: true,
                onGenerateRoute: route.onGenerateRoute,
                theme: controller.value,
                builder: buildChild,
              ),
            ),
          ),
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
