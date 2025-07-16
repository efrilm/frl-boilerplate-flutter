import 'dart:io';

import 'package:frl_boilerplate/commands/create_domain.dart';
import 'package:frl_boilerplate/commands/create_feature.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('''
  Usage:
    dart run frl_boilerplate domain <name>
    dart run frl_boilerplate feature <name>
  ''');
    exit(0);
  }

  final command = args[0];

  switch (command) {
    case 'domain':
      if (args.length < 2) {
        print('❌ Missing name for domain.');
        exit(1);
      }
      final name = args[1];
      createDomain(name);
      break;

    case 'feature':
      if (args.length < 2) {
        print('❌ Missing name for feature.');
        exit(1);
      }
      final name = args[1];
      createFeature(name);
      break;

    default:
      print('❌ Unknown command: $command');
  }
}
