import 'dart:io';
import 'package:frl_boilerplate/commands/create_feature.dart';
import 'package:test/test.dart';

void main() {
  group('createFeature', () {
    const featureName = 'auth';
    final baseDir = Directory('lib/features/$featureName');

    setUp(() {
      if (baseDir.existsSync()) {
        baseDir.deleteSync(recursive: true);
      }
    });

    test('should create feature folders', () {
      createFeature(featureName);

      expect(Directory('lib/features/$featureName/data').existsSync(), isTrue);
      expect(Directory('lib/features/$featureName/domain').existsSync(), isTrue);
      expect(Directory('lib/features/$featureName/presentation').existsSync(), isTrue);
    });

    tearDown(() {
      if (baseDir.existsSync()) {
        baseDir.deleteSync(recursive: true);
      }
    });
  });
}
