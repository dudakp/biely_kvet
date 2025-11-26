import 'package:biely_kvet/domain/core/adaptive/platform_aware.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(BielyKvetApp());
}

class BielyKvetApp extends PlatformAwareStatelessWidget {
  BielyKvetApp({super.key});

  @override
  Widget buildAndroid(BuildContext context) {
    return MaterialApp(
      title: 'Biely kvet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.materialLightTheme,
      darkTheme: AppTheme.cupertinoDarkTheme,

      themeMode: ThemeMode.system,
      initialRoute: Routes.home,
      routes: Routes.all,
    );
  }

  @override
  Widget buildIos(BuildContext context) {
    return CupertinoApp(
      title: 'Biely kvet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.cupertinoThemeData,
      initialRoute: Routes.home,
      routes: Routes.all,
    );
  }
}
