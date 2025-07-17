import 'package:dio/dio.dart';

class BadRequestError extends DioException {
  final DioException dioError;
  final String? messageError;

  BadRequestError(this.dioError, this.messageError)
      : super(
          error: dioError.error,
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
