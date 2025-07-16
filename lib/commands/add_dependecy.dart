import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// Adds required dependencies and dev_dependencies
/// into pubspec.yaml
void addDependencies() {
  final packages = [
    'auto_route',
    'connectivity_plus',
    'data_channel',
    'dio',
    'get_it',
    'freezed_annotation',
    'injectable',
    'intl',
    'json_annotation',
    'path',
    'path_provider',
    'json_serializable',
    'dartz',
  ];

  final devPackages = [
    'auto_route_generator',
    'build_runner',
    'freezed',
    'awesome_dio_interceptor',
    'injectable_generator',
  ];

  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    print('❌ pubspec.yaml not found!');
    return;
  }

  final content = pubspecFile.readAsStringSync();
  final editor = YamlEditor(content);

  // Add dependencies
  for (var pkg in packages) {
    print('  ➕ Adding $pkg...');
    _addDependency(editor, pkg);
  }

  // Add dev_dependencies
  for (var pkg in devPackages) {
    print('  ➕ Adding $pkg (dev)...');
    _addDependency(editor, pkg, isDev: true);
  }

  pubspecFile.writeAsStringSync(editor.toString());

  print('\n🚀 Running dart pub get...');
  final result = Process.runSync('dart', ['pub', 'get']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);
}

void _addDependency(YamlEditor editor, String packageName, {bool isDev = false}) {
  final section = isDev ? 'dev_dependencies' : 'dependencies';

  // Check if already exists
  final currentDeps = editor.parseAt([section]);
  if (currentDeps.value is YamlMap && (currentDeps.value as YamlMap).containsKey(packageName)) {
    print('    ⏭️  $packageName already exists, skipping...');
    return;
  }

  try {
    editor.update([section, packageName], 'any');
  } catch (_) {
    // if section doesn't exist like dev_dependencies
    editor.update([section], {packageName: 'any'});
  }
}
