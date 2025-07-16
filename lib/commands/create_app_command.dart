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
}
