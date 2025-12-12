import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(BielyKvetApp());
}

class BielyKvetApp extends _PlatformAwareStatelessWidget {
  const BielyKvetApp({super.key});

  @override
  Widget buildAndroid(BuildContext context) {
    return MaterialApp(
      title: 'Biely kvet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.materialLightTheme,
      darkTheme: AppTheme.cupertinoDarkTheme,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('sk')],
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('sk')],
      initialRoute: Routes.home,
      routes: Routes.all,
    );
  }
}

abstract class _PlatformAwareWidget {
  Widget buildIos(BuildContext context);

  Widget buildAndroid(BuildContext context);
}

abstract class _PlatformAwareStatelessWidget extends StatelessWidget
    implements _PlatformAwareWidget {
  const _PlatformAwareStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? buildIos(context) : buildAndroid(context);
  }
}
