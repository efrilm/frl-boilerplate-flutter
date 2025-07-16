import 'dart:io';

void createFeature(String name) {
  final base = 'lib/features/$name';
  final dirs = [
    '$base/data',
    '$base/domain',
    '$base/presentation',
  ];

  for (final dir in dirs) {
    Directory(dir).createSync(recursive: true);
  }

  print('✅ Feature "$name" structure created!');
}
