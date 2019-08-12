import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApplicationTheme with ChangeNotifier {
  ApplicationTheme() {
    _value = stickyLight;
  }

  get stickyLight => ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white,
          iconTheme: ThemeData.light().iconTheme,
        ),
        textTheme: ThemeData.light()
            .textTheme
            .apply(bodyColor: Colors.black, displayColor: Colors.black),
      );

  ThemeData _value;

  // TODO(microtears) set value to _value before release.
  ThemeData get value => stickyLight;

  set value(e) {
    _value = e;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
