import 'dart:io';

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

  Logger.success('Create app folder Success');
}
