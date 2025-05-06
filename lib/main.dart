import 'package:dyd/core/config/theme/theme.dart';
import 'package:dyd/dependency_injection.dart';
import 'package:dyd/feature/auth/screen/login_screen.dart';
import 'package:dyd/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/data/remote-data/shared_prefs.dart';

void main() {
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DYD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      home: SplashScreen(),
    );
  }
}
