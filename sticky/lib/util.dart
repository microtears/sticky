import 'dart:developer';

import 'package:flutter/widgets.dart';

bool handleStreamError<T>(AsyncSnapshot<T> snapshot) {
  final result = snapshot.hasData;
  if (!result) {
    log("stream error: $snapshot");
  }
  return result;
}
