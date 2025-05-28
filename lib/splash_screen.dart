import 'package:dyd/feature/auth/screen/login_screen.dart';
import 'package:dyd/feature/auth/widget/gradient_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/config/asset-image-path/asset_image_path.dart';
import 'core/config/spacing/static_spacing_helper.dart';
import 'core/data/remote-data/shared_prefs.dart';
import 'core/typo/white_typo.dart';
import 'feature/landing/screen/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void fNavigateAfterDelay() {
    Future.delayed(const Duration(seconds: 5), () {
      String? token = PreferenceUtils.getString("token");
      if (token != null) {
        Get.off(() => const NavigationScreen());
      } else {
        Get.off(() => const LoginScreen());
      }
    });
  }

  @override
  void initState() {
    fNavigateAfterDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainerWidget(
          widget: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageHelper.appLogoPNG),
          Spacing.verticalSpace(10),
          Text(
            "Win Big Today!",
            style: TypoWhite.white70024,
          ),
        ],
      )),
    );
  }
}
