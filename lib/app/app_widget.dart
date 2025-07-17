import 'package:flutter/material.dart';

import '../app/theme/theme.dart';
import '../common/constant/app_constant.dart';
import 'injection.dart';
import 'routes/app_router.dart';
import 'routes/app_router_observer.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstant.appName,
      theme: ThemeApp.theme,
      routerConfig: _appRouter.config(
        navigatorObservers: () => <NavigatorObserver>[AppRouteObserver()],
      ),
    );
  }
}
