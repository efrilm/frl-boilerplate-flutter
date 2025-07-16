import 'dart:io';

import 'package:frl_boilerplate/commands/create_env_command.dart';
import 'package:frl_boilerplate/commands/create_injection_config.dart';
import 'package:frl_boilerplate/utils/logger.dart';

void createApp() {
  Logger.section('Create app folder...');

  final baseDir = Directory('lib/app');

  if (baseDir.existsSync()) {
    Logger.warning('⏭️ lib/app already exists. Skipping folder creation.');
  } else {
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

    // Only create env & injection if lib/app is newly created
    createEnv();
    createInjection();

    Logger.success('Create app folder Success');
  }
}
