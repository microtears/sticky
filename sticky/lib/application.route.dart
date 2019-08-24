// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:sticky/page/complete_profile.dart';
import 'package:sticky/page/home.dart';
import 'package:sticky/page/login.dart';
import 'package:sticky/page/setting.dart';
import 'package:sticky/page/start.dart';
import 'package:sticky/page/sticky.dart';
import 'package:sticky/page/welcome.dart';

const ROUTE_COMPLETE_PROFILE_PAGE = 'complete_profile_page';
const ROUTE_HOME = '/';
const ROUTE_LOGIN_PAGE = 'login_page';
const ROUTE_SETTING_PAGE = 'setting_page';
const ROUTE_START_PAGE = 'start_page';
const ROUTE_STICKY_PAGE = 'sticky_page';
const ROUTE_WELCOME_PAGE = 'welcome_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._completeProfilePage.entries,
      ..._home.entries,
      ..._loginPage.entries,
      ..._settingPage.entries,
      ..._startPage.entries,
      ..._stickyPage.entries,
      ..._welcomePage.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _completeProfilePage = <String, RouteFactory>{
  'complete_profile_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => CompleteProfilePage(),
      ),
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ),
};
Map<String, RouteFactory> _loginPage = <String, RouteFactory>{
  'login_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => LoginPage(),
      ),
};
Map<String, RouteFactory> _settingPage = <String, RouteFactory>{
  'setting_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => SettingPage(),
      ),
};
Map<String, RouteFactory> _startPage = <String, RouteFactory>{
  'start_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => StartPage(),
      ),
};
Map<String, RouteFactory> _stickyPage = <String, RouteFactory>{
  'sticky_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) =>
            StickyPage(sticky: settings.arguments),
      ),
};
Map<String, RouteFactory> _welcomePage = <String, RouteFactory>{
  'welcome_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => WelcomePage(),
      ),
};
