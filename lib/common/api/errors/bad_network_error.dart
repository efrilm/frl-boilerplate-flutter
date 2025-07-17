import 'package:dio/dio.dart';

class BadNetworkError extends DioException {
  final DioException dioError;

  BadNetworkError(this.dioError)
      : super(
          requestOptions: dioError.requestOptions,
          error: dioError.error,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
