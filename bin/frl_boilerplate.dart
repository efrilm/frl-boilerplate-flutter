import 'dart:io';

import 'package:frl_boilerplate/commands/create_app_command.dart';
import 'package:frl_boilerplate/commands/create_assets_command.dart';
import 'package:frl_boilerplate/commands/create_common_command.dart';
import 'package:frl_boilerplate/commands/create_domain.dart';
import 'package:frl_boilerplate/commands/create_env_command.dart';
import 'package:frl_boilerplate/commands/create_feature.dart';
import 'package:frl_boilerplate/commands/create_injection_config.dart';
import 'package:frl_boilerplate/commands/create_router_command.dart';
import 'package:frl_boilerplate/commands/create_theme_command.dart';
import 'package:frl_boilerplate/commands/init_project_command.dart';
import 'package:frl_boilerplate/utils/logger.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print('''
  Usage:
    dart run frl_boilerplate init
    dart run frl_boilerplate domain <name>
    dart run frl_boilerplate feature <name>
    dart run frl_boilerplate create-app
    dart run frl_boilerplate create-asset
    dart run frl_boilerplate create-env
    dart run frl_boilerplate create-injection
    dart run frl_boilerplate create-common
    dart run frl_boilerplate update-analysis-option
    dart run frl_boilerplate create-theme
    dart run frl_boilerplate create-router
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

    case 'create-app':
      createApp();
      break;

    case 'create-asset':
      createAssetFolders();
      break;

    case 'create-env':
      createEnv();
      break;

    case 'create-injection':
      createInjection();
      break;

    case 'create-common':
      createCommon();
      break;

    case 'update-analysis-option':
      createCommon();
      break;

    case 'create-theme':
      createTheme();
      break;

    case 'create-router':
      createRouter();
      break;

    default:
      Logger.error('Unknown command: $command');
  }
}
