import 'dart:io';
import 'package:yaml_edit/yaml_edit.dart';
import 'package:yaml/yaml.dart';

import 'package:frl_boilerplate/utils/logger.dart';

void createAssetFolders() {
  final folders = [
    'assets/images',
    'assets/icons',
    'assets/fonts',
    'assets/json',
  ];

  Logger.section('Create asset folders...');
  for (var folder in folders) {
    final dir = Directory(folder);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      Logger.success('Created folder: $folder');
    } else {
      Logger.warning('⏭️ Folder already exists: $folder');
    }
  }

  Logger.success('Create asset folders Success');
  _updatePubspec(folders);
}

void _updatePubspec(List<String> assetPaths) {
  Logger.section('Update Pubspec...');
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    Logger.error('pubspec.yaml not found!');
    return;
  }

  final content = pubspecFile.readAsStringSync();
  final editor = YamlEditor(content);

  try {
    final flutterNode = editor.parseAt(['flutter']);
    final flutterMap = flutterNode.value as YamlMap;

    var assetsList = <String>[];
    if (flutterMap.containsKey('assets')) {
      final assetsNode = flutterMap['assets'];
      if (assetsNode is YamlList) {
        assetsList = List<String>.from(assetsNode.nodes.map((n) => n.value.toString()));
      }
    }

    var changed = false;
    for (final path in assetPaths) {
      final normalizedPath = path.endsWith('/') ? path : '$path/';
      if (!assetsList.contains(normalizedPath)) {
        assetsList.add(normalizedPath);
        changed = true;
        Logger.success('Added asset path to pubspec.yaml: $normalizedPath');
      } else {
        Logger.warning('⏭️ Asset path already exists in pubspec.yaml: $normalizedPath');
      }
    }

    if (changed) {
      editor.update(['flutter', 'assets'], assetsList);
      pubspecFile.writeAsStringSync(editor.toString());
      Logger.success('pubspec.yaml updated with asset paths.');
    } else {
      Logger.info('No changes needed for pubspec.yaml.');
    }
  } catch (e) {
    // flutter section might not exist yet
    Logger.warning('flutter section not found in pubspec.yaml. Creating it.');

    editor.update([
      'flutter'
    ], {
      'assets': assetPaths.map((p) => p.endsWith('/') ? p : '$p/').toList(),
    });

    pubspecFile.writeAsStringSync(editor.toString());
    Logger.success('pubspec.yaml created/updated with asset paths.');
  }

  Logger.success('Update Pubspec Success');
}
