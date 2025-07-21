import 'dart:io';

import 'package:frl_boilerplate/commands/run_comand.dart';
import 'package:frl_boilerplate/utils/logger.dart';
import 'package:frl_boilerplate/utils/string_utils.dart';

void createFeature(String name) {
  String camel = toSnakeCase(name);

  final base = 'lib/features/$camel';
  Directory(base).createSync(recursive: true);

  createInfrastructure(name);
  createDomain(name);
  createPresentation(name);
  runBuildRunner();

  Logger.success('🎉 Feature "$name" structure created with default contents!');
}

/// Create Infrastructure Layer
void createInfrastructure(String name) {
  final base = 'lib/features/$name/infrastructure';
  final pascalName = toPascalCase(name);
  final camelName = toSnakeCase(name);

  final dirs = [
    '$base/datasources',
    '$base/models',
    '$base/repositories',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/${camelName}_dtos.dart': '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../common/api/api_client.dart';
import '../domain/$camelName.dart';

part 'datasources/${camelName}_remote_data_source.dart';
part 'repositories/${camelName}_repository.dart';
part 'models/${camelName}_model.dart';
part '${camelName}_dtos.freezed.dart';
part '${camelName}_dtos.g.dart';

''',
    '$base/datasources/${camelName}_remote_data_source.dart': '''
part of '../${camelName}_dtos.dart';

@injectable
class ${pascalName}RemoteDataProvider {
  final ApiClient _apiClient;
  final String _logName = '${pascalName}RemoteDataProvider';

  ${pascalName}RemoteDataProvider(this._apiClient);
}
''',
    '$base/models/${camelName}_model.dart': '''
part of '../${camelName}_dtos.dart';

@freezed
class ${pascalName}Dto with _\$${pascalName}Dto {
  const ${pascalName}Dto._();

   const factory ${pascalName}Dto() = _${pascalName}Dto;

   factory ${pascalName}Dto.fromJson(Map<String, dynamic> json) => _\$${pascalName}DtoFromJson(json);

   $pascalName toDomain() => $pascalName();
}
''',
    '$base/repositories/${camelName}_repository.dart': '''
part of '../${camelName}_dtos.dart';
@Injectable(as: I${pascalName}Repository)
class ${pascalName}Repository implements I${pascalName}Repository {
  final ${pascalName}RemoteDataProvider _remoteDataProvider;
  final String _logName = '${pascalName}Repository';

  ${pascalName}Repository(this._remoteDataProvider);


}
''',
  };

  _writeFiles(files);
}

/// Create Domain Layer
void createDomain(String name) {
  final base = 'lib/features/$name/domain';
  final pascalName = toPascalCase(name);
  final camelName = toSnakeCase(name);

  final dirs = [
    '$base/entities',
    '$base/repositories',
    '$base/failures',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/$camelName.dart': '''
import 'package:dartz/dartz.dart' hide id;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/api/api_failure.dart';

part '$camelName.freezed.dart';
part 'failures/${camelName}_failure.dart';
part 'repositories/i_${camelName}_repository.dart';
part 'entities/$camelName.dart';
''',
    '$base/entities/$camelName.dart': '''
part of '../$camelName.dart';
@freezed
class $pascalName with _\$$pascalName {
  const $pascalName._();

   const factory $pascalName() = _$pascalName;

   factory $pascalName.empty() => const $pascalName();
  }
''',
    '$base/repositories/i_${camelName}_repository.dart': '''
part of '../$camelName.dart';
abstract class I${pascalName}Repository {}
''',
    '$base/failures/${camelName}_failure.dart': '''
part of '../$camelName.dart';

@freezed
sealed class ${pascalName}Failure with _\$${pascalName}Failure {
  const factory ${pascalName}Failure.serverError(ApiFailure failure) = _ServerError;
  const factory ${pascalName}Failure.unexpectedError() = _UnexpectedError;
  const factory ${pascalName}Failure.dynamicErrorMessage(
    String erroMessage,
  ) = _DynamicErrorMessage;
}

''',
  };

  _writeFiles(files);
}

/// Create Presentation Layer
Future<void> createPresentation(String name) async {
  final base = 'lib/features/$name/presentation';
  final pascalName = toPascalCase(name);
  final camelName = toSnakeCase(name);
  final dirs = [
    '$base/pages',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/pages/${camelName}_page.dart': '''
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ${pascalName}Page extends StatelessWidget {
  const ${pascalName}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$pascalName Page'),
      ),
      body: const Center(
        child: Text('This is the $pascalName page'),
      ),
    );
  }
}
''',
  };

  _writeFiles(files);

  await updateRoutes("${pascalName}Route", '${pascalName}Page');
}

/// Write file if not exists
void _writeFiles(Map<String, String> files) {
  files.forEach((path, content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      Logger.success('Created: $path');
    } else {
      Logger.warning('Already exists: $path');
    }
  });
}

Future<void> updateRoutes(String routeName, String pageClass) async {
  final filePath = 'lib/app/router/app_router.dart';
  final file = File(filePath);

  if (!file.existsSync()) {
    Logger.error('$filePath not found.');
    return;
  }

  var content = file.readAsStringSync();

  // 1. Tambahkan import jika belum ada
  final importStatement = "import 'app_router.gr.dart';";
  if (!content.contains(importStatement)) {
    content = content.replaceFirst(
      "import 'package:auto_route/auto_route.dart';",
      "import 'package:auto_route/auto_route.dart';\n$importStatement",
    );
  }

  // 2. Cek apakah route sudah ada
  if (content.contains('$routeName.page')) {
    Logger.skip('$routeName already exists in routes.');
    return;
  }

  // 3. Sisipkan ke dalam list route
  final pattern = RegExp(r'List<AutoRoute>\s+get\s+routes\s*=>\s*\[\s*([\s\S]*?)\];');
  final match = pattern.firstMatch(content);

  if (match != null) {
    final existingRoutes = match.group(1);
    final newRoutes = '$existingRoutes\n        AutoRoute(page: $routeName.page),';
    final newContent =
        content.replaceRange(match.start, match.end, 'List<AutoRoute> get routes => [\n$newRoutes\n      ];');

    file.writeAsStringSync(newContent);
    Logger.success('Route $routeName added successfully.');
  } else {
    Logger.error('Failed to locate route list in app_router.dart.');
  }
}
