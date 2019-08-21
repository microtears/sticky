import 'package:sticky/data/file_cache.dart';

const _kUrl = "https://v1.hitokoto.cn/?c=e";

String _parseHitokoto(json) => (json as Map<String, dynamic>)["hitokoto"];

Future<String> fetchHitokoto() =>
    fromCache(_kUrl, parse: _parseHitokoto, maxAge: Duration(days: 1));
