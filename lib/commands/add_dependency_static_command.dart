import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

import '../utils/logger.dart';
import '../data/dependency_versions.dart';

Future<void> addDependencieWithStatic() async {
  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    Logger.error('pubspec.yaml not found!');
    return;
  }

  final content = pubspecFile.readAsStringSync();
  final editor = YamlEditor(content);

  Logger.section('Adding dependencies...');
  for (var pkg in staticDependencies.entries) {
    _addDependency(editor, pkg.key, version: pkg.value);
  }

  Logger.section('Adding dev dependencies...');
  for (var pkg in staticDevDependencies.entries) {
    _addDependency(editor, pkg.key, version: pkg.value, isDev: true);
  }

  _addFlutterGenConfig(editor);
  _createLauncherIconYaml();

  pubspecFile.writeAsStringSync(editor.toString());

  Logger.section('Running dart pub get...');
  final result = Process.runSync('dart', ['pub', 'get']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  Logger.success('Dependencies and flutter_gen config added successfully.');
}

void _addDependency(
  YamlEditor editor,
  String packageName, {
  required String version,
  bool isDev = false,
}) {
  final section = isDev ? 'dev_dependencies' : 'dependencies';

  try {
    final currentDeps = editor.parseAt([section]);
    if (currentDeps.value is YamlMap && (currentDeps.value as YamlMap).containsKey(packageName)) {
      Logger.skip('$packageName already exists, skipping...');
      return;
    }
  } catch (_) {
    // section belum ada
  }

  try {
    editor.update([section, packageName], version);
    Logger.success('$packageName: $version added.');
  } catch (_) {
    editor.update([section], {packageName: version});
    Logger.success('$packageName: $version added.');
  }
}

void _addFlutterGenConfig(YamlEditor editor) {
  final path = ['flutter_gen'];

  try {
    editor.parseAt(path);
    Logger.skip('flutter_gen config already exists, skipping...');
    return;
  } catch (_) {
    editor.update(path, {
      'output': 'lib/app/assets/',
      'integrations': {
        'flutter_svg': true,
      },
    });
    Logger.success('flutter_gen config added.');
  }
}

void _createLauncherIconYaml() {
  final file = File('launcher_icon.yaml');
  if (file.existsSync()) {
    Logger.skip('launcher_icon.yaml already exists, skipping...');
    return;
  }

  final content = '''
# Generate: dart run flutter_launcher_icons -f launcher_icon.yaml

flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "your_path"
  remove_alpha_ios: true
  min_sdk_android: 21 # android min sdk min:16, default 21
  web:
    generate: true
    image_path: "your_path"
  windows:
    generate: true
    image_path: "your_path"
    icon_size: 48
''';

  file.writeAsStringSync(content);
  Logger.success('launcher_icon.yaml created from inline template.');
}
