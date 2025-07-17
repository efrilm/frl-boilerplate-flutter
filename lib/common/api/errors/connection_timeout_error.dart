import 'package:dio/dio.dart';

class ConnectionTimeoutError extends DioException {
  final DioException dioError;

  ConnectionTimeoutError(this.dioError)
      : super(
          error: dioError.error,
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
