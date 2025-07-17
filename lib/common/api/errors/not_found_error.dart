import 'package:dio/dio.dart';

class NotFoundError extends DioException {
  final DioException dioError;
  final String? messageError;

  NotFoundError(this.dioError, this.messageError)
      : super(
          error: dioError.error,
          requestOptions: dioError.requestOptions,
          response: dioError.response,
          type: dioError.type,
          message: dioError.message,
          stackTrace: dioError.stackTrace,
        );
}
