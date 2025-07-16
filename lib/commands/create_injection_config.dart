import 'dart:io';
import 'package:frl_boilerplate/utils/logger.dart';

void createInjection() {
  Logger.section('Generating injection.dart...');

  final path = 'lib/app';
  final filePath = '$path/injection.dart';
  final file = File(filePath);

  if (!Directory(path).existsSync()) {
    Directory(path).createSync(recursive: true);
    Logger.success('Created folder: $path');
  }

  if (file.existsSync()) {
    Logger.warning('⏭️ injection.dart already exists. Skipped generating.');
    return;
  }

  final content = '''
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(String env) => getIt.init(environment: env);
''';

  file.writeAsStringSync(content);
  Logger.success('injection.dart generated at: $filePath');
}
