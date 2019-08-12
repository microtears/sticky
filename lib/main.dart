import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shine/shine.dart';
import 'package:sticky/application.dart';

void main() {
  runApp(Application());
  if (Platform.isAndroid) {
    setTranslateStatusBar();
  }
}
