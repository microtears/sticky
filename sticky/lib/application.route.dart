// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:sticky/page/home.dart';
import 'package:sticky/page/login.dart';
import 'package:sticky/page/profile.dart';
import 'package:sticky/page/sticky.dart';

const ROUTE_HOME = '/';
const ROUTE_LOGIN_PAGE = 'login_page';
const ROUTE_PROFILE_PAGE = 'profile_page';
const ROUTE_STICKY_PAGE = 'sticky_page';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._home.entries,
      ..._loginPage.entries,
      ..._profilePage.entries,
      ..._stickyPage.entries,
    ])[settings.name](settings);

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
Map<String, RouteFactory> _profilePage = <String, RouteFactory>{
  'profile_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => ProfilePage(),
      ),
};
Map<String, RouteFactory> _stickyPage = <String, RouteFactory>{
  'sticky_page': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => StickyPage(),
      ),
};
