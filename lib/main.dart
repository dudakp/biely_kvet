import 'package:flutter/material.dart';
import 'config/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const BielyKvetApp());
}

class BielyKvetApp extends StatelessWidget {
  const BielyKvetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biely kvet',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.home,
      routes: Routes.all,
    );
  }
}
