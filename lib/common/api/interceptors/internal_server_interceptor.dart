import 'package:dio/dio.dart';

import '../errors/internal_server_error.dart';

class InternalServerErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      if (err.response?.statusCode != null &&
          err.response!.statusCode! >= 500 &&
          err.response!.statusCode! < 600) {
        return super.onError(InternalServerError(err), handler);
      }
    }

    super.onError(err, handler);
  }
}
