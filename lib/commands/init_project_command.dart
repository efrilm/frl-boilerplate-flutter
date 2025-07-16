import 'package:frl_boilerplate/commands/add_dependecy_command.dart';
import 'package:frl_boilerplate/commands/create_app_command.dart';
import 'package:frl_boilerplate/commands/update_analysis_options_command.dart';
import 'package:frl_boilerplate/commands/create_assets_command.dart';
import 'package:frl_boilerplate/commands/create_common_command.dart';
import 'package:frl_boilerplate/utils/logger.dart';

Future<void> initProject() async {
  Logger.section('🔧 Running frl_boilerplate init...');

  updateAnalysisOptions();
  createAssetFolders();
  createApp();
  await addDependencies();
  createCommon();

  Logger.section('✅ frl_boilerplate init completed!');
}
