import 'dart:io';
import 'package:frl_boilerplate/utils/logger.dart';

void updateAnalysisOptions() {
  Logger.section('Updating analysis_options.yaml...');

  final file = File('analysis_options.yaml');
  final content = '''
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    sort_pub_dependencies: false
    prefer_relative_imports: true

analyzer:
  errors:
    missing_required_param: error
    missing_return: error
    must_be_immutable: error
    sort_unnamed_constructors_first: ignore
    invalid_annotation_target: ignore
    use_build_context_synchronously: ignore
  exclude:
    - test/generated/**
    - "**/**.g.dart"
    - "**/**.freezed.dart"
''';

  if (file.existsSync()) {
    file.writeAsStringSync(content);
    Logger.success('analysis_options.yaml updated at: ${file.path}');
  } else {
    file.writeAsStringSync(content);
    Logger.success('analysis_options.yaml created at: ${file.path}');
  }
}
