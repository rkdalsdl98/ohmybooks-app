import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ohmybooks_app/datasource/interceptor/api_log_interceptor.dart';

class ApiManager {
  Future<Response> getRequestByBookAPI(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final url = dotenv.env['APIURL'];
      final apiKey = dotenv.env['APIKEY'];

      if (url == null || apiKey == null) {
        throw Error.safeToString("EnvLoadError");
      }

      final BaseOptions options = BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(seconds: 120),
        sendTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        maxRedirects: 6,
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Authorization": "KakaoAK $apiKey",
        },
        queryParameters: queryParams,
      );

      final Dio dio = Dio(options)..interceptors.add(ApiLogInterceptor());

      return await dio.get(path);
    } catch (e) {
      rethrow;
    }
  }
}
