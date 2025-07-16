import 'dart:io';

import 'package:frl_boilerplate/utils/logger.dart';

void createAssetFolders() {
  final folders = [
    'assets/images',
    'assets/icons',
    'assets/fonts',
    'assets/json',
  ];

  Logger.section('Create asset folders...');
  for (var folder in folders) {
    final dir = Directory(folder);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      Logger.success('Created folder: $folder');
    } else {
      Logger.warning('⏭️ Folder already exists: $folder');
    }
  }
}
