import 'dart:io';

import 'package:frl_boilerplate/commands/create_router_command.dart';
import 'package:frl_boilerplate/commands/create_theme_command.dart';
import 'package:frl_boilerplate/utils/logger.dart';

void createApp() {
  Logger.section('Create app folder...');

  final baseDir = Directory('lib/app');

  baseDir.createSync(recursive: true);
  Logger.success('Created folder: ${baseDir.path}');

  final subfolders = [
    'router',
    'theme',
  ];

  for (var folder in subfolders) {
    Directory('${baseDir.path}/$folder').createSync(recursive: true);
    Logger.success('Created folder: $folder');
  }

  createTheme();
  createRouter();

  Logger.success('Create app folder Success');

  Logger.section('Generate app widget..');
  File('${baseDir.path}/app_widget.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import '../app/theme/theme.dart';
import '../common/constant/app_constant.dart';
import 'injection.dart';
import 'routes/app_router.dart';
import 'routes/app_router_observer.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeApp.theme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => <NavigatorObserver>[AppRouteObserver()],
      ),
    );
  }
}
''');
  Logger.success('Generate app widget success');
}
