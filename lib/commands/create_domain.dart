import 'dart:io';

import 'package:frl_boilerplate/utils/string_utils.dart';

void createDomain(String name) {
  final baseDir = Directory('lib/domain/$name');
  baseDir.createSync(recursive: true);

  // Subfolders
  final subfolders = ['failure', 'model', 'repository'];
  for (var folder in subfolders) {
    Directory('${baseDir.path}/$folder').createSync(recursive: true);
  }

  // Files to create
  final pascalName = toPascalCase(name);
  final snakeName = toSnakeCase(name);

  // user.dart
  File('${baseDir.path}/$snakeName.dart').writeAsStringSync('''
part 'failure/${snakeName}_failure.dart';
part 'model/${snakeName}_model.dart';
part 'repository/i_${snakeName}_repository.dart';
''');

  // failure/user_failure.dart
  File('${baseDir.path}/failure/${snakeName}_failure.dart').writeAsStringSync('''
part of '../$snakeName.dart';
class ${pascalName}Failure {
  // TODO: define failures
}
''');

  // model/user_model.dart
  File('${baseDir.path}/model/${snakeName}_model.dart').writeAsStringSync('''
part of '../$snakeName.dart';
class ${pascalName}Model {
  // TODO: define model
}
''');

  // repository/i_user_repository.dart
  File('${baseDir.path}/repository/i_${snakeName}_repository.dart').writeAsStringSync('''
part of '../$snakeName.dart';
abstract class I${pascalName}Repository {
  // TODO: define repository interface
}
''');

  print('✅ Domain layer for "$name" created!');
}
