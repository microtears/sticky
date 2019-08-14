import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
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
      child: Consumer<ThemeController>(
        builder: (context, controller, child) =>
            AnnotatedRegion<SystemUiOverlayStyle>(
          value: (controller.value.brightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light)
              .copyWith(statusBarColor: controller.stickyTheme.backgroundColor),
          child: MaterialApp(
            initialRoute: "/",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: route.onGenerateRoute,
            theme: controller.value,
          ),
        ),
      ),
      providers: _providers,
    );
  }
}
