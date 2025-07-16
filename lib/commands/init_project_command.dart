import 'package:frl_boilerplate/commands/add_dependecy_command.dart';
import 'package:frl_boilerplate/commands/create_assets_command.dart';

Future<void> initProject() async {
  print('🔧 Running frl_boilerplate init...');

  await addDependencies();
  createAssetFolders();

  print('✅ frl_boilerplate init completed!');
}
