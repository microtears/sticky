import 'dart:convert';

import 'package:http/http.dart' as http;

const _kUrl = "https://v1.hitokoto.cn/?c=e";

Future<String> fetchHitokoto() async {
  final result = await http.read(_kUrl);
  return (jsonDecode(result) as Map<String, dynamic>)["hitokoto"];
}
