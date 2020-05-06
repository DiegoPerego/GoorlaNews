import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goorlanews/model/article.dart';

const String API = "https://newsapi.org/v2/";
const String TOP_HEADLINES = "top-headlines";
const String TOKEN = "1454d540d8a747bda6da926d48534780";

class Api {
  final Dio dio = Dio();
  final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(baseUrl: API));

  Api() {
    dio.options.baseUrl = API;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();

    if (!kIsWeb) dio.interceptors.add(dioCacheManager.interceptor);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (options.extra.isNotEmpty) {
        options.queryParameters.addAll(options.extra);
      }
      // Do something before request is sent
      options.queryParameters['apiKey'] = TOKEN;
      options.queryParameters['country'] = "it";
      return options;
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  Future<List<Article>> getArticles({String category, String search}) async {
    Response response = await dio.get(TOP_HEADLINES,
        options: buildCacheOptions(Duration(seconds: 120),
            options: Options(extra: createExtras(category, search))));

    return response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  Map<String, dynamic> createExtras(String category, String query) {
    LinkedHashMap<String, dynamic> map = LinkedHashMap();
    if (category != null) map['category'] = category;
    if (query != null) map['q'] = query;
    return map;
  }
}
