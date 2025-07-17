class CommonFileApiString {
  static String apiClient = '''
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../app/env.dart';
import 'api_failure.dart';
import 'errors/bad_network_error.dart';
import 'errors/bad_request_error.dart';
import 'errors/connection_timeout_error.dart';
import 'errors/internal_server_error.dart';
import 'errors/not_found_error.dart';
import 'errors/unauthorized_error.dart';
import 'interceptors/bad_network_interceptor.dart';
import 'interceptors/bad_request_interceptor.dart';
import 'interceptors/connection_timeout_interceptor.dart';
import 'interceptors/internal_server_interceptor.dart';
import 'interceptors/not_found_interceptor.dart';
import 'interceptors/unauthorized_interceptor.dart';

@lazySingleton
class ApiClient {
  final Dio _dio;
  final Env _env;

  ApiClient(this._dio, this._env) {
    _dio.options.baseUrl = _env.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.interceptors.add(BadNetworkErrorInterceptor());
    _dio.interceptors.add(BadRequestErrorInterceptor());
    _dio.interceptors.add(InternalServerErrorInterceptor());
    _dio.interceptors.add(NotFoundErrorInterceptor());
    _dio.interceptors.add(UnauthorizedInterceptor());
    _dio.interceptors.add(ConnectionTimeoutErrorInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(
        AwesomeDioInterceptor(logResponseHeaders: false, logRequestTimeout: false, logRequestHeaders: true),
      );
    }
  }

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool followRedirects = true,
    bool Function(int?)? validateStatus,
    String? contentType,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(
          headers: headers,
          followRedirects: followRedirects,
          validateStatus: validateStatus,
          contentType: contentType,
        ),
        queryParameters: params,
      );
    } on UnauthorizedError catch (e) {
      throw ApiFailure.unauthorized(e.messageError);
    } on InternalServerError {
      throw const ApiFailure.internalServerError();
    } on BadNetworkError {
      throw const ApiFailure.connectionError();
    } on BadRequestError catch (e) {
      throw ApiFailure.badRequest(e.messageError);
    } on NotFoundError catch (e) {
      throw ApiFailure.notFound(e.messageError);
    } on ConnectionTimeoutError {
      throw const ApiFailure.connectionTimeout();
    } on DioException catch (e) {
      var errorMessage = e.response?.data['message'] ?? e.response?.statusMessage ?? e.error;

      if (errorMessage.toString().contains('Connection reset')) {
        errorMessage = 'Connection reset';
      }

      throw ApiFailure.serverError(statusCode: e.response?.statusCode ?? 0, errorMessage: errorMessage.toString());
    } catch (e, s) {
      throw ApiFailure.unexpectedError(errorMessage: e, stackTrace: s);
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool followRedirects = true,
    bool Function(int?)? validateStatus,
    String? contentType,
  }) async {
    try {
      return await _dio.get(
        path,
        options: Options(
          headers: headers,
          followRedirects: followRedirects,
          validateStatus: validateStatus,
          contentType: contentType,
        ),
        queryParameters: params,
      );
    } on UnauthorizedError catch (e) {
      throw ApiFailure.unauthorized(e.messageError);
    } on InternalServerError {
      throw const ApiFailure.internalServerError();
    } on BadNetworkError {
      throw const ApiFailure.connectionError();
    } on BadRequestError catch (e) {
      throw ApiFailure.badRequest(e.messageError);
    } on NotFoundError catch (e) {
      throw ApiFailure.notFound(e.messageError);
    } on ConnectionTimeoutError {
      throw const ApiFailure.connectionTimeout();
    } on DioException catch (e) {
      var errorMessage = e.response?.data['message'] ?? e.response?.statusMessage ?? e.error;

      if (errorMessage.toString().contains('Connection reset')) {
        errorMessage = 'Connection reset';
      }

      throw ApiFailure.serverError(statusCode: e.response?.statusCode ?? 0, errorMessage: errorMessage.toString());
    } catch (e, s) {
      throw ApiFailure.unexpectedError(errorMessage: e, stackTrace: s);
    }
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool followRedirects = true,
    bool Function(int?)? validateStatus,
    String? contentType,
    void Function(int count, int total)? onSendProgress,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        options: Options(
          headers: headers,
          followRedirects: followRedirects,
          validateStatus: validateStatus,
          contentType: contentType,
        ),
        queryParameters: params,
        onSendProgress: onSendProgress,
      );
    } on UnauthorizedError catch (e) {
      throw ApiFailure.unauthorized(e.messageError);
    } on InternalServerError {
      throw const ApiFailure.internalServerError();
    } on BadNetworkError {
      throw const ApiFailure.connectionError();
    } on BadRequestError catch (e) {
      throw ApiFailure.badRequest(e.messageError);
    } on NotFoundError catch (e) {
      throw ApiFailure.notFound(e.messageError);
    } on ConnectionTimeoutError {
      throw const ApiFailure.connectionTimeout();
    } on DioException catch (e) {
      var errorMessage = e.response?.data['message'] ?? e.response?.statusMessage ?? e.error;

      if (errorMessage.toString().contains('Connection reset')) {
        errorMessage = 'Connection reset';
      }

      throw ApiFailure.serverError(statusCode: e.response?.statusCode ?? 0, errorMessage: errorMessage.toString());
    } catch (e, s) {
      throw ApiFailure.unexpectedError(errorMessage: e, stackTrace: s);
    }
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? params,
    bool followRedirects = true,
    bool Function(int?)? validateStatus,
    String? contentType,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        options: Options(
          headers: headers,
          followRedirects: followRedirects,
          validateStatus: validateStatus,
          contentType: contentType,
        ),
        queryParameters: params,
      );
    } on UnauthorizedError catch (e) {
      throw ApiFailure.unauthorized(e.messageError);
    } on InternalServerError {
      throw const ApiFailure.internalServerError();
    } on BadNetworkError {
      throw const ApiFailure.connectionError();
    } on BadRequestError catch (e) {
      throw ApiFailure.badRequest(e.messageError);
    } on NotFoundError catch (e) {
      throw ApiFailure.notFound(e.messageError);
    } on DioException catch (e) {
      throw ApiFailure.serverError(
        statusCode: e.response?.statusCode ?? 0,
        errorMessage: e.response?.data['message'] ?? e.response?.statusMessage ?? e.error,
      );
    } catch (e, s) {
      throw ApiFailure.unexpectedError(errorMessage: e, stackTrace: s);
    }
  }
}
''';
  static String apiFailure = '''
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
sealed class ApiFailure with _\$ApiFailure {
  const ApiFailure._();

  const factory ApiFailure.serverError({
    required int statusCode,
    required Object errorMessage,
  }) = _ServerError;

  const factory ApiFailure.unexpectedError({
    required Object errorMessage,
    required StackTrace stackTrace,
  }) = _UnexpectedError;

  const factory ApiFailure.connectionError() = _ConnectionError;

  const factory ApiFailure.internalServerError() = _InternalServerError;

  const factory ApiFailure.unauthorized(String? message) = _Unauthorized;

  const factory ApiFailure.badRequest(String? message) = _BadRequest;

  const factory ApiFailure.notFound(String? message) = _NotFound;

  const factory ApiFailure.connectionTimeout() = _ConnectionTimeout;

  String toStringFormatted(
    BuildContext context, {
    String? unauthorizedMessage,
  }) {
    return switch (this) {
      _ServerError(:final statusCode, :final errorMessage) =>
        'There is a problem with the server. Status code: \$statusCode Error: \$errorMessage',

      _UnexpectedError() => 'An error occurred. Please try again later.',

      _ConnectionError() => 'No Internet',

      _InternalServerError() =>
        'The server is experiencing problems. Please try again later.',

      _Unauthorized(:final message) =>
        message ?? unauthorizedMessage ?? 'Session has expired.',

      _BadRequest(:final message) =>
        message ?? 'There is an incorrect entry. Please check again',

      _NotFound(:final message) => message ?? 'Not Found',

      _ConnectionTimeout() => 'Connection Timeout',
    };
  }
}
''';
  static String apiErrorsBadNetwork = '''
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
''';
  static String apiErrorsBadRequest = '''
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
''';
  static String apiErrorsConnectionTimeout = '''
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
''';
  static String apiErrorsInternalServerError = '''
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
''';
  static String apiErrorsNotFound = '''
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
''';
  static String apiErrorsUnauthorized = '''
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
''';
  static String apiInterceptorBadNetwork = '''
import 'package:dio/dio.dart';

import '../../../app/injection.dart';
import '../../network/network_client.dart';
import '../errors/bad_network_error.dart';

class BadNetworkErrorInterceptor extends Interceptor {
  final _networkClient = getIt<NetworkClient>();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isConnected = await _networkClient.isConnected;

    if (err.type == DioExceptionType.connectionTimeout ||
        !isConnected ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return super.onError(BadNetworkError(err), handler);
    }
    super.onError(err, handler);
  }
}
''';
  static String apiInterceptorBadRequest = '''
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
''';
  static String apiInterceptorConnectionTimeout = '''
import 'package:dio/dio.dart';

import '../errors/connection_timeout_error.dart';

class ConnectionTimeoutErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout) {
      return super.onError(ConnectionTimeoutError(err), handler);
    }
    super.onError(err, handler);
  }
}
''';
  static String apiInterceptorInternalServer = '''
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
''';
  static String apiInterceptorNotFound = '''
import 'package:dio/dio.dart';

import '../errors/not_found_error.dart';

class NotFoundErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 404) {
      return super.onError(NotFoundError(err, null), handler);
    }
    super.onError(err, handler);
  }
}
''';
  static String apiInterceptorUnauthorized = '''
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
''';
}
