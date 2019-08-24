import 'dart:developer';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:shine/shine.dart';
import 'package:sticky/application.route.dart';
import 'package:sticky/data/kvalue.dart';
import 'package:sticky/data/theme.dart';
import 'package:sticky/data/user.dart';
import 'package:sticky/page/functions.dart';
import 'package:sticky/page/library.dart';
import 'package:sticky/page/search.dart';
import 'package:sticky/page/waterfall.dart';
import 'package:sticky/sticky_logo.dart';

@RoutePage(isInitialRoute: true)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MemorizedFutureBuilder<UserInfo>(
      future: checkSignIn,
      builder: (context, AsyncSnapshot<UserInfo> snapshot) {
        if (snapshot.hasData && snapshot.data.user != null) {
          return buildHome(context);
        } else {
          log(snapshot.error.toString());
          return buildInit(context);
        }
      },
    );
  }

  Future<UserInfo> checkSignIn() async {
    final user = await kAuth.currentUser();
    if (user != null) {
      UserInfo.of(context, listen: false).user = user;
    } else {
      Navigator.pushReplacementNamed(context, ROUTE_WELCOME_PAGE);
    }
    return UserInfo.of(context, listen: false);
  }

  Widget buildHome(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: <Widget>[
                Waterfall(
                  onSearchButton: () => setState(() {
                    currentIndex = 1;
                  }),
                ),
                Search(),
                Library(),
              ],
            ),
          ),
          BottomNavigationBarWrap(
            child: BottomNavigationBar(
              backgroundColor: StickyTheme.of(context).bottomNavigationBarColor,
              elevation: 0,
              currentIndex: currentIndex,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text("Search"),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  title: Text("Your Library"),
                ),
              ],
              onTap: handleBottomNavigationItemTap,
            ),
            onLongPress: onLongPress,
          )
        ],
      ),
    );
  }

  Widget buildInit(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StickyLogo(
          controller: StickyLogoController()..isLoading = true,
        ),
      ),
    );
  }

  void handleBottomNavigationItemTap(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  void onLongPress(int value) {
    if (value == 0) {
      newSticky(context);
    } else if (value == 1) {
      ThemeController.of(context).refresh();
      log("refresh theme");
    }
  }
}
