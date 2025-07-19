import 'dart:io';

import 'package:frl_boilerplate/utils/string_utils.dart';

void createFeature(String name) {
  String camel = toSnakeCase(name);

  final base = 'lib/features/$camel';
  Directory(base).createSync(recursive: true);

  createInfrastructure(camel);
  createDomain(camel);
  createPresentation(camel);

  print('🎉 Feature "$camel" structure created with default contents!');
}

/// Create Infrastructure Layer
void createInfrastructure(String name) {
  final base = 'lib/features/$name/infrastructure';
  final pascalName = toPascalCase(name);
  final dirs = [
    '$base/datasources',
    '$base/models',
    '$base/repositories',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/${name}_dtos.dart': '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../common/api/api_client.dart';

part 'datasources/${name}_remote_data_source.dart';
part 'repositories/${name}_repository';
part 'models/${name}_model.dart';
part '${name}_dtos.freezed.dart';
part '${name}_dtos.g.dart';

''',
    '$base/datasources/${name}_remote_data_source.dart': '''
part of '../${name}_dtos.dart';

@injectable
class ${pascalName}RemoteDataProvider {
  final ApiClient _apiClient;
  final String _logName = '${pascalName}RemoteDataProvider';

  ${pascalName}RemoteDataProvider(this._apiClient);
}
''',
    '$base/models/${name}_model.dart': '''
part of '../${name}_dtos.dart';

@freezed
class ${pascalName}Dto with _\$${pascalName}Dto {
  const ${pascalName}Dto._();

   const factory ${pascalName}Dto({ }) = _${pascalName}Dto;

   factory ${pascalName}Dto.fromJson(Map<String, dynamic> json) => _\$${pascalName}DtoFromJson(json);

   pascalName toDomain() => pascalName();
}
''',
    '$base/repositories/${name}_repository.dart': '''
part of '../${name}_dtos.dart';
@Injectable(as: IAuthRepository)
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
  final dirs = [
    '$base/entities',
    '$base/repositories',
    '$base/usecases',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/entities/$name.dart': '''
class ${toPascalCase(name)} {
  // TODO: define entity
}
''',
    '$base/repositories/${name}_repository.dart': '''
abstract class ${toPascalCase(name)}Repository {
  // TODO: define repository contract
}
''',
    '$base/usecases/request_$name.dart': '''
import '../repositories/${name}_repository.dart';

class Request${toPascalCase(name)} {
  final ${toPascalCase(name)}Repository repository;

  Request${toPascalCase(name)}(this.repository);

  // TODO: implement usecase
}
''',
  };

  _writeFiles(files);
}

/// Create Presentation Layer
void createPresentation(String name) {
  final base = 'lib/features/$name/presentation';
  final dirs = [
    '$base/cubit',
    '$base/pages',
  ];

  for (var dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  final files = {
    '$base/cubit/${name}_cubit.dart': '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '${name}_state.dart';

class ${toPascalCase(name)}Cubit extends Cubit<${toPascalCase(name)}State> {
  ${toPascalCase(name)}Cubit() : super(${toPascalCase(name)}Initial());

  // TODO: implement cubit logic
}
''',
    '$base/cubit/${name}_state.dart': '''
abstract class ${toPascalCase(name)}State {}

class ${toPascalCase(name)}Initial extends ${toPascalCase(name)}State {}
''',
    '$base/pages/${name}_page.dart': '''
import 'package:flutter/material.dart';

class ${toPascalCase(name)}Page extends StatelessWidget {
  const ${toPascalCase(name)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('${toPascalCase(name)} Page'),
      ),
      body: const Center(
        child: Text('This is the ${toPascalCase(name)} page'),
      ),
    );
  }
}
''',
  };

  _writeFiles(files);
}

/// Write file if not exists
void _writeFiles(Map<String, String> files) {
  files.forEach((path, content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.writeAsStringSync(content);
      print('✅ Created: $path');
    } else {
      print('⚠️ Already exists: $path');
    }
  });
}

/// Convert to PascalCase

/// Convert to camelCase
