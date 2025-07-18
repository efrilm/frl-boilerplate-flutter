import 'dart:io';

import 'package:frl_boilerplate/utils/logger.dart';

Future<void> runBuildRunner() async {
  Logger.section('🚀 Running build_runner...');

  try {
    final result = await Process.run(
      'dart',
      ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
    );

    if (result.exitCode == 0) {
      Logger.success('✅ build_runner completed successfully!');
      Logger.info(result.stdout);
    } else {
      Logger.error('❌ build_runner failed!');
      Logger.error(result.stderr);
    }
  } catch (e) {
    Logger.error('❗ Error running build_runner: $e');
  }
}
