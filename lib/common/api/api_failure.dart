import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_failure.freezed.dart';

@freezed
sealed class ApiFailure with _$ApiFailure {
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
        'There is a problem with the server. Status code: $statusCode Error: $errorMessage',

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
