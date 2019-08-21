import 'dart:ui';

import 'package:shine/shine.dart';
import 'package:sticky/data/file_cache.dart';

const _kUrl =
    "https://raw.githubusercontent.com/webkul/coolhue/master/scripts/coolhue.json";

List<List<Color>> _parseCoolHue(json) {
  return (json as List<List<String>>)
      .map((colors) => colors.map((e) => hexColor(e)).toList())
      .toList();
}

Future<List<List<Color>>> get coolhue => fromCache(_kUrl, parse: _parseCoolHue);
