import 'dart:io';

import 'package:frl_boilerplate/utils/logger.dart';

void createSplashFeature() {
  final baseDir = Directory('lib/features/splash');
  baseDir.createSync(recursive: true);

  if (!baseDir.existsSync()) {
    Logger.warning('Splash folder already exists');
  } else {
    Logger.success('Created folder: ${baseDir.path}');
  }

  // Create Presentation Folder
  final presentationDir = Directory('${baseDir.path}/presentation');
  presentationDir.createSync(recursive: true);

  if (!presentationDir.existsSync()) {
    Logger.warning('Presentation folder already exists');
  } else {
    Logger.success('Created folder: ${presentationDir.path}');
  }

  // Create Bloc folder
  final blocDir = Directory('${presentationDir.path}/bloc');
  blocDir.createSync(recursive: true);

  if (!blocDir.existsSync()) {
    Logger.warning('Bloc folder already exists');
  } else {
    Logger.success('Created folder: ${blocDir.path}');
  }

  // Create Pages Folder
  final pagesDir = Directory('${presentationDir.path}/pages');
  pagesDir.createSync(recursive: true);

  if (!pagesDir.existsSync()) {
    Logger.warning('Pages folder already exists');
  } else {
    Logger.success('Created folder: ${pagesDir.path}');
  }

  File('${pagesDir.path}/splash_page.dart').writeAsStringSync('''
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Center(
        child: Text("Splash Page"),
      ),
    );
  }
}
''');
}
