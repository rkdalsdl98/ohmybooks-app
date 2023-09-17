import 'package:dio/dio.dart';

class ApiLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("${options.method}: ${options.path}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("${response.statusCode}: ${response.requestOptions.path}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print("${err.response?.statusCode}: ${err.requestOptions.path}");
    print(err.toString());
    super.onError(err, handler);
  }
}
