import 'package:flutter/material.dart';
import 'package:showcase_project/di/scopes/global_scope.dart';
import 'package:showcase_project/features/theme/theme.dart';
import 'package:showcase_project/features/utils/flavor.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppTheme _appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    _appTheme.addListener(_onThemeChanged);
  }

  @override
  void dispose() {
    _appTheme.removeListener(_onThemeChanged);
    super.dispose();
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: FlavorConfig.appName,
      routerConfig: context.global.router.config,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _appTheme.themeMode,
    );
  }
}
