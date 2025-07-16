import 'dart:io';
import 'package:frl_boilerplate/utils/logger.dart';

void createEnv() {
  Logger.section('Generating env.dart...');

  final path = 'lib';
  final filePath = '$path/env.dart';
  final file = File(filePath);

  if (!Directory(path).existsSync()) {
    Directory(path).createSync(recursive: true);
    Logger.success('Created folder: $path');
  }

  if (file.existsSync()) {
    Logger.warning('⏭️ env.dart already exists. Skipped generating.');
    return;
  }

  final content = '''
import 'package:injectable/injectable.dart';

abstract class Env {
  String get baseUrl;
  // add getter here...
}

@Injectable(as: Env)
@dev
class DevEnv implements Env {
  @override
  String get baseUrl => ''; // example value
}

@Injectable(as: Env)
@prod
class ProdEnv implements Env {
  @override
  String get baseUrl => '';
}
''';

  file.writeAsStringSync(content);
  Logger.success('env.dart generated at: $filePath');
}
