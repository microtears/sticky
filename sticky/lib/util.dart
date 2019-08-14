import 'dart:developer';

import 'package:flutter/widgets.dart';

bool handleStreamError<T>(AsyncSnapshot<T> snapshot) {
  final result = snapshot.hasData && snapshot.data != null;
  if (!result && snapshot.connectionState == ConnectionState.active) {
    log("stream error: $snapshot");
  }
  return result;
}
