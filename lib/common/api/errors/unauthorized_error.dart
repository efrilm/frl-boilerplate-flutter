import 'package:dio/dio.dart';

class UnauthorizedError extends DioException {
  final DioException dioError;
  final String? messageError;

  UnauthorizedError(this.dioError, this.messageError)
      : super(
          requestOptions: dioError.requestOptions,
          error: dioError.error,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
