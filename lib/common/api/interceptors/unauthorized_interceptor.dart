import 'package:dio/dio.dart';

import '../errors/unauthorized_error.dart';

class UnauthorizedInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 403 ||
        err.response?.statusCode == 419) {
      return super.onError(UnauthorizedError(err, null), handler);
    }
    super.onError(err, handler);
  }
}
