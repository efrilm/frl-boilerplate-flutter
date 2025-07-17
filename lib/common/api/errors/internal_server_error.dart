  import 'package:dio/dio.dart';

class InternalServerError extends DioException {
  final DioException dioError;

  InternalServerError(this.dioError)
      : super(
          requestOptions: dioError.requestOptions,
          error: dioError.error,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
