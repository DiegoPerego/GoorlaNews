import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:goorlanews/bimbi/models/customer.dart';

const String API = "http://www.mocky.io/v2/";
const String API_POINTMENT = "5ecd463c320000820023687c";

class BimbyApi {
  final Dio dio = Dio();
  final DioCacheManager dioCacheManager =
      DioCacheManager(CacheConfig(baseUrl: API));

  BimbyApi() {
    dio.options.baseUrl = API;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();

    if (!kIsWeb) dio.interceptors.add(dioCacheManager.interceptor);

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      if (options.extra.isNotEmpty) {
        options.queryParameters.addAll(options.extra);
      }
      return options;
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  Future<List<Customer>> getCustomers() async {
    Response response = await dio.get(API_POINTMENT,
        options: buildCacheOptions(Duration(seconds: 120)));

    return response.data['customers']
        .map<Customer>((json) => Customer.fromJson(json))
        .toList();
  }
}
