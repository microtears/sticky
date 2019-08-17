import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:sticky/data/theme.dart';
import 'package:sticky/page/functions.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = ThemeController.of(context);
    return AnimatedTheme(
      data: ThemeController.of(context).theme,
      duration: Duration(milliseconds: 800),
      child: Scaffold(
        appBar: AppBar(
          title: Text("设置"),
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text("启用黑暗模式"),
              trailing: Switch.adaptive(
                value: themeController.value == ThemeController.stickyDark,
                onChanged: (bool enable) => themeController.value = enable
                    ? ThemeController.stickyDark
                    : ThemeController.stickyLight,
              ),
            ),
            ListTile(
              title: FlatButton(
                child: Text("注销"),
                onPressed: () => signOut(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
