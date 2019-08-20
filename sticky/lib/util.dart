import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

bool handleStreamError<T>(AsyncSnapshot<T> snapshot) {
  final result = snapshot.hasData && snapshot.data != null;
  if (!result && snapshot.connectionState == ConnectionState.active) {
    log("stream error: $snapshot");
  }
  return result;
}

Color randomColor() {
  final random = math.Random(DateTime.now().microsecondsSinceEpoch);
  return Color.fromARGB(
      255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
}
