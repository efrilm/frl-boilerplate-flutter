import 'dart:io';

import 'package:frl_boilerplate/commands/create_domain.dart';
import 'package:frl_boilerplate/commands/create_feature.dart';
import 'package:frl_boilerplate/commands/init_project_command.dart';
import 'package:frl_boilerplate/utils/logger.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('''
  Usage:
    dart run frl_boilerplate domain <name>
    dart run frl_boilerplate feature <name>
    dart run frl_boilerplate init
  ''');
    exit(0);
  }

  final command = args[0];

  switch (command) {
    case 'init':
      await initProject();
      break;

    case 'domain':
      if (args.length < 2) {
        Logger.error('Missing name for domain.');
        exit(1);
      }
      final name = args[1];
      createDomain(name);
      break;

    case 'feature':
      if (args.length < 2) {
        Logger.error('Missing name for feature.');
        exit(1);
      }
      final name = args[1];
      createFeature(name);
      break;

    default:
      Logger.error('Unknown command: $command');
  }
}
