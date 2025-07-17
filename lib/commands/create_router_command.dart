import 'dart:io';

import 'package:frl_boilerplate/utils/logger.dart';

void createRouter() {
  Logger.section('Generating router ...');
  final baseDir = Directory('lib/app/router');

  if (!baseDir.existsSync()) {
    baseDir.createSync(recursive: true);
    Logger.success('Created folder: ${baseDir.path}');
  } else {
    Logger.warning('⏭️ Folder already exists: ${baseDir.path}');
  }

  final files = [
    {
      'name': 'app_router.dart',
      'content': '''
import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // Splash
        AutoRoute(page: SplashRoute.page, initial: true),
      ];
}
'''
    },
    {
      'name': 'app_router_observer.dart',
      'content': '''
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: \${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: \${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: \${route.name}');
  }
}
'''
    },
  ];

  int createdCount = 0;

  for (var file in files) {
    final filePath = '${baseDir.path}/${file['name']}';
    final fileObj = File(filePath);

    if (fileObj.existsSync()) {
      Logger.warning('⏭️ File already exists: $filePath');
    } else {
      fileObj.writeAsStringSync(file['content']!);
      Logger.success('Created: $filePath');
      createdCount++;
    }
  }

  if (createdCount > 0) {
    Logger.success('Generated router file(s) successfully.');
  } else {
    Logger.warning('⏭️ No router files were generated. All files already exist.');
  }
}
