import 'dart:io';
import '../utils/logger.dart';

void replaceMain() {
  final mainFile = File('lib/main.dart');

  final content = '''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../app/injection.dart';
import '../app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  if (kReleaseMode) {
    debugPrint = (message, {wrapWidth}) => '';
  }

  await configureDependencies(
    kReleaseMode ? Environment.prod : Environment.dev,
  );

  runApp(const AppWidget());
}
  ''';

  if (!mainFile.existsSync()) {
    Logger.info('main.dart not found. Creating...');
  } else {
    Logger.info('Replacing main.dart...');
  }

  mainFile.createSync(recursive: true);
  mainFile.writeAsStringSync(content);

  Logger.success('main.dart replaced successfully.');
}
