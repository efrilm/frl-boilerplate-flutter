import 'dart:io';
import 'dart:convert';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

Future<void> addDependencies() async {
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
    await _addDependency(editor, pkg);
  }

  print('\n🛠️ Adding dev dependencies...');
  for (var pkg in devPackages) {
    await _addDependency(editor, pkg, isDev: true);
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

Future<void> _addDependency(
  YamlEditor editor,
  String packageName, {
  bool isDev = false,
}) async {
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

  final version = await _fetchLatestVersion(packageName);

  try {
    editor.update([section, packageName], version);
    print('    ✅ $packageName: $version added.');
  } catch (_) {
    editor.update([section], {packageName: version});
    print('    ✅ $packageName: $version added.');
  }
}

Future<String> _fetchLatestVersion(String packageName) async {
  final url = Uri.parse('https://pub.dev/api/packages/$packageName');

  try {
    final request = await HttpClient().getUrl(url);
    final response = await request.close();

    if (response.statusCode == 200) {
      final jsonString = await response.transform(utf8.decoder).join();
      final jsonMap = json.decode(jsonString);
      final version = jsonMap['latest']['version'];

      if (version != null) {
        return '^$version';
      } else {
        print('    ⚠️ No version info for $packageName. Using "any".');
        return 'any';
      }
    } else {
      print('    ⚠️ Failed to fetch version for $packageName (status ${response.statusCode}). Using "any".');
      return 'any';
    }
  } catch (e) {
    print('    ⚠️ Error fetching version for $packageName: $e. Using "any".');
    return 'any';
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

  final content = '''
# Generate: dart run flutter_launcher_icons -f launcher_icons.yaml

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

  print('    ✅ launcher_icon.yaml created from inline template.');
}
