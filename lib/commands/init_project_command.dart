import 'package:frl_boilerplate/commands/add_dependecy_command.dart';
import 'package:frl_boilerplate/commands/create_assets_command.dart';
import 'package:frl_boilerplate/utils/logger.dart';

Future<void> initProject() async {
  Logger.section('🔧 Running frl_boilerplate init...');

  await addDependencies();
  createAssetFolders();

  Logger.section('✅ frl_boilerplate init completed!');
}
