import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shine/shine.dart';
import 'package:path_provider/path_provider.dart' as app_path;
import 'package:path/path.dart' as path;

const _kUrl =
    "https://raw.githubusercontent.com/webkul/coolhue/master/scripts/coolhue.json";
const _kFilename = "coolhue.json";

Future<String> _fetchCoolHue() async {
  final response = await http.read(_kUrl);
  final start = '{"colors": ';
  final end = '}';
  return "$start$response$end";
}

List<List<Color>> _parseAndDecodeCoolHue(String response) {
  Map<String, List<List<String>>> data = jsonDecode(response);
  return data["colors"]
      .map((colors) => colors.map((e) => hexColor(e)).toList())
      .toList();
}

Future<List<List<Color>>> _computeCoolHue(String text) async {
  return await compute(_parseAndDecodeCoolHue, text);
}

List<List<Color>> _coolhue;

Future<List<List<Color>>> get coolhue async {
  // check memory
  if (_coolhue != null) {
    return _coolhue;
  }
  final documents = await app_path.getApplicationDocumentsDirectory();
  final file = File(path.join(documents.path, _kFilename));
  // check file
  if (await file.exists()) {
    _coolhue = await _computeCoolHue(await file.readAsString());
    return _coolhue;
  }
  final result = await _fetchCoolHue();
  _coolhue = await _computeCoolHue(result);
  file.create().then((e) => e.writeAsString(result));
  return _coolhue;
}
