class CommonFolderString {
  static String api = 'api';
  static String constant = 'constant';
  static String di = 'di';
  static String extension = 'extension';
  static String formatter = 'formatter';
  static String function = 'function';
  static String network = 'network';
  static String url = 'url';
  static String validator = 'validator';
  static String components = 'components';
}

class CommonFileString {
  static String base = '''
  // TODO: define your code
''';
  static String constans = '''
class AppConstant {
  static const String appName = "";
}
''';
  static String function = '''
import 'package:flutter/material.dart';

void dismissKeyboard(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
''';

  static String diAutoRoute = '''
import 'package:injectable/injectable.dart';

import '../../app/router/app_router.dart';

@module
abstract class AutoRouteDi {
  @lazySingleton
  AppRouter get appRouter => AppRouter();
}
''';
  static String diConnectivity = '''
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ConnectivityDi {
  @lazySingleton
  Connectivity get connectivity => Connectivity();
}
''';
  static String diDio = '''
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioDi {
  @lazySingleton
  Dio get dio => Dio();
}
''';
  static String diSharedPreference = '''
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesDi {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
''';
  static String networkClient = '''
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkClient extends NetworkInfoBase {
  final Connectivity connectivity;

  NetworkClient(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }
}

abstract class NetworkInfoBase {
  Future<bool> get isConnected;
}
''';
}
