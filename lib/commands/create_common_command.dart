import 'dart:io';

import 'package:frl_boilerplate/utils/logger.dart';

void createCommon() {
  Logger.section('Create common folder...');
  final baseDir = Directory('lib/common');
  baseDir.createSync(recursive: true);

  // Subfolders
  final subfolders = [
    'api',
    'constants',
    'di',
    'extension',
    'formatter',
    'function',
    'network',
    'url',
    'validator',
    'components'
  ];
  for (var folder in subfolders) {
    Directory('${baseDir.path}/$folder').createSync(recursive: true);
    Logger.success('Created folder: $folder');
  }

  Logger.success('Create common folder Success');
}
