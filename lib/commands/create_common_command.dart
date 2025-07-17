import 'dart:io';

import 'package:frl_boilerplate/commands/create_common_file_command.dart';
import 'package:frl_boilerplate/constants/common_string.dart';
import 'package:frl_boilerplate/utils/logger.dart';

void createCommon() {
  Logger.section('Create common folder...');
  final baseDir = Directory('lib/common');
  baseDir.createSync(recursive: true);

  // Subfolders
  final subfolders = [
    CommonFolderString.api,
    CommonFolderString.constant,
    CommonFolderString.di,
    CommonFolderString.extension,
    CommonFolderString.formatter,
    CommonFolderString.function,
    CommonFolderString.network,
    CommonFolderString.url,
    CommonFolderString.validator,
    CommonFolderString.components,
  ];

  for (var folder in subfolders) {
    Directory('${baseDir.path}/$folder').createSync(recursive: true);
    Logger.success('Created folder: $folder');
    createCommonFile(folder);
  }

  Logger.success('Create common folder Success');
}
