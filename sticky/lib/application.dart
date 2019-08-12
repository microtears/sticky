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
    ChangeNotifierProvider.value(value: ApplicationTheme()),
    ChangeNotifierProvider.value(value: UserInfo()),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Consumer<ApplicationTheme>(
        builder: (context, theme, child) =>
            AnnotatedRegion<SystemUiOverlayStyle>(
          value: (theme.value.brightness == Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light)
              .copyWith(statusBarColor: theme.value.backgroundColor),
          child: MaterialApp(
            initialRoute: "/",
            debugShowCheckedModeBanner: false,
            onGenerateRoute: route.onGenerateRoute,
            theme: theme.value,
          ),
        ),
      ),
      providers: _providers,
    );
  }
}
