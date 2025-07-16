import 'dart:io';
import 'package:frl_boilerplate/commands/create_domain.dart';
import 'package:test/test.dart';

void main() {
  group('createDomain', () {
    const testName = 'test_user';
    final testDir = Directory('lib/domain/$testName');

    setUp(() {
      // remove folder if exist
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }
    });

    test('should create domain folder and files', () {
      createDomain(testName);

      // check folder exists
      expect(testDir.existsSync(), isTrue);

      // check entity file exists
      final entityFile = File('lib/domain/$testName/${testName}_entity.dart');
      expect(entityFile.existsSync(), isTrue);

      // check repository file exists
      final repoFile = File('lib/domain/$testName/${testName}_repository.dart');
      expect(repoFile.existsSync(), isTrue);

      // optionally check file contents
      final content = entityFile.readAsStringSync();
      expect(content.contains('class TestUserEntity'), isTrue);
    });

    tearDown(() {
      // remove folder after test
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }
    });
  });
}
