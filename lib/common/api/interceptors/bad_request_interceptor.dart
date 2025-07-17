import 'package:dio/dio.dart';

import '../errors/bad_request_error.dart';

class BadRequestErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 422 ||
        err.response?.statusCode == 400 ||
        err.response?.statusCode == 405) {
      return super.onError(BadRequestError(err, null), handler);
    }
    super.onError(err, handler);
  }
}
