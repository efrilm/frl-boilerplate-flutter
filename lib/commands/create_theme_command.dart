import 'dart:io';
import 'package:frl_boilerplate/utils/logger.dart';

void createTheme() {
  Logger.section('Generating theme...');
  final baseDir = Directory('lib/app/theme');

  if (!baseDir.existsSync()) {
    baseDir.createSync(recursive: true);
    Logger.success('Created folder: ${baseDir.path}');
  } else {
    Logger.warning('Folder already exists: ${baseDir.path}');
  }

  final files = [
    {
      'name': 'theme.dart',
      'content': '''
import 'package:flutter/material.dart';

part 'color_app.dart';
part 'style_app.dart';
part 'value_app.dart';

class ThemeApp {
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
      );
}
'''
    },
    {
      'name': 'app_color.dart',
      'content': '''
part of 'theme.dart';

class AppColor {
  // TODO: define color
}
'''
    },
    {
      'name': 'app_style.dart',
      'content': '''
part of 'theme.dart';

class AppStyle {
  // TODO: define style
}
'''
    },
    {
      'name': 'app_value.dart',
      'content': '''
part of 'theme.dart';

class AppValue {
  // TODO: define value
}
'''
    },
  ];

  int createdCount = 0;

  for (var file in files) {
    final filePath = '${baseDir.path}/${file['name']}';
    final fileObj = File(filePath);

    if (fileObj.existsSync()) {
      Logger.warning('File already exists: $filePath');
    } else {
      fileObj.writeAsStringSync(file['content']!);
      Logger.success('Created: $filePath');
      createdCount++;
    }
  }

  if (createdCount > 0) {
    Logger.success('Generated theme file(s) successfully.');
  } else {
    Logger.warning('No theme files were generated. All files already exist.');
  }
}
