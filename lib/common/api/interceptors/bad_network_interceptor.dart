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
