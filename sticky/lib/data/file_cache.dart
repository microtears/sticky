import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:quiver/cache.dart';

typedef ParseCallback<T> = T Function(dynamic);

final _memoryCache = MapCache<String, dynamic>.lru();
final _fileCache = DiskCacheManager();


Future _compute(String source) => compute(jsonDecode, source);

dynamic _noParse(any) => any;

const ParseCallback _kDefaultParseCallback = _noParse;

Future<R> fromDiskCache<R>(
  String url, {
  ParseCallback<R> parse = _kDefaultParseCallback,
  bool decode = false,
  Map<String, String> headers,
  Duration maxAge,
}) =>
    _fileCache
        .getSingleFileEx(url, headers: headers, maxAge: maxAge)
        .then((e) => decode ? e.readAsString() : e)
        .then((e) => decode ? _compute(e) : e)
        .then(parse);

Future<R> fromCache<R>(
  String url, {
  ParseCallback<R> parse = _kDefaultParseCallback,
  bool decode = true,
  Map<String, String> headers,
  Duration maxAge,
}) =>
    _memoryCache.get(url,
        ifAbsent: (key) => fromDiskCache(
              key,
              parse: parse,
              decode: decode,
              headers: headers,
              maxAge: maxAge,
            ));

class DiskCacheManager extends BaseCacheManager {
  static const key = "libCachedFileData";
  static const _response_header_tag = "--no-";
  static DiskCacheManager _instance;

  factory DiskCacheManager() {
    if (_instance == null) {
      _instance = new DiskCacheManager._();
    }
    return _instance;
  }

  DiskCacheManager._()
      : super(
          key,
          maxAgeCacheObject: Duration(days: 15),
          maxNrOfCacheObjects: 200,
          fileFetcher: _httpGetter,
        );

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return p.join(directory.path, key);
  }

  Future<File> getSingleFileEx(
    String url, {
    Map<String, String> headers,
    Duration maxAge,
  }) async =>
      getSingleFile(url,
          headers: _transformHeaders(
            headers,
            maxAge: maxAge,
          ));

  Map<String, String> _transformHeaders(
    Map<String, String> headers, {
    Duration maxAge,
  }) {
    if (maxAge != null) {
      headers["${_response_header_tag}cache-control"] =
          "max-age=${maxAge.inSeconds}";
    }
    return headers;
  }

  static Future<FileFetcherResponse> _httpGetter(String url,
      {Map<String, String> headers}) async {
    var httpResponse = await _getResponse(url, headers: headers);
    return new HttpFileFetcherResponse(httpResponse);
  }

  static Future<http.Response> _getResponse(String url,
      {Map<String, String> headers}) async {
    final addHeader = <String, String>{};
    final originHeaders = headers
      ..removeWhere((key, value) {
        final needRemove = key.startsWith(_response_header_tag);
        if (needRemove) {
          addHeader[key.substring(_response_header_tag.length)] = value;
        }
        return needRemove;
      });
    final httpResponse = await http.get(url, headers: originHeaders);
    httpResponse.headers.addAll(addHeader);
    return httpResponse;
  }
}
