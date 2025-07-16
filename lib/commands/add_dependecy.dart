import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

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
    'flutter_svg',
  ];

  final devPackages = [
    'auto_route_generator',
    'build_runner',
    'freezed',
    'awesome_dio_interceptor',
    'injectable_generator',
    'flutter_gen_runner',
    'flutter_launcher_icons',
  ];

  final pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    print('❌ pubspec.yaml not found!');
    return;
  }

  final content = pubspecFile.readAsStringSync();
  final editor = YamlEditor(content);

  print('\n📦 Adding dependencies...');
  for (var pkg in packages) {
    _addDependency(editor, pkg);
  }

  print('\n🛠️ Adding dev dependencies...');
  for (var pkg in devPackages) {
    _addDependency(editor, pkg, isDev: true);
  }

  // Add flutter_gen config
  _addFlutterGenConfig(editor);

  pubspecFile.writeAsStringSync(editor.toString());

  // Create launcher_icon.yaml
  _createLauncherIconYaml();

  print('\n🚀 Running dart pub get...');
  final result = Process.runSync('dart', ['pub', 'get']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  print('\n✅ Dependencies and flutter_gen config added successfully.');
}

void _addDependency(
  YamlEditor editor,
  String packageName, {
  bool isDev = false,
}) {
  final section = isDev ? 'dev_dependencies' : 'dependencies';

  // Check if section already exists
  YamlNode? currentDeps;
  try {
    currentDeps = editor.parseAt([section]);
  } catch (_) {
    // section not yet exists
  }

  if (currentDeps?.value is YamlMap) {
    final map = currentDeps!.value as YamlMap;
    if (map.containsKey(packageName)) {
      print('    ⏭️  $packageName already exists, skipping...');
      return;
    }
  }

  try {
    editor.update([section, packageName], 'any');
    print('    ✅ $packageName added.');
  } catch (_) {
    // If section itself doesn't exist
    editor.update([section], {packageName: 'any'});
    print('    ✅ $packageName added.');
  }
}

void _addFlutterGenConfig(YamlEditor editor) {
  final path = ['flutter_gen'];

  try {
    editor.parseAt(path);
    print('    ⏭️  flutter_gen config already exists, skipping...');
    return;
  } catch (_) {
    // If not exists → add new
    editor.update(path, {
      'output': 'lib/shared/assets/',
      'integrations': {
        'flutter_svg': true,
      },
    });
    print('    ✅ flutter_gen config added.');
  }
}

void _createLauncherIconYaml() {
  final file = File('launcher_icon.yaml');
  if (file.existsSync()) {
    print('    ⏭️  launcher_icon.yaml already exists, skipping...');
    return;
  }

  final templateFile = File('templates/launcher_icon_template.yaml');
  if (!templateFile.existsSync()) {
    print('❌ Template launcher_icon_template.yaml not found!');
    return;
  }

  final content = templateFile.readAsStringSync();

  file.writeAsStringSync(content);

  print('    ✅ launcher_icon.yaml created from template.');
}
