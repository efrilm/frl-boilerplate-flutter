import 'package:frl_boilerplate/commands/add_dependecy.dart';

Future<void> initProject() async {
  print('🔧 Running frl_boilerplate init...');

  await addDependencies();

  print('✅ frl_boilerplate init completed!');
}
