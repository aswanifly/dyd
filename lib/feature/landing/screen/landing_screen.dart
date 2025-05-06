import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/feature/cart/screen/cart_screen.dart';
import 'package:dyd/feature/home/screen/home_screen.dart';
import 'package:dyd/feature/landing/controller/landing_controller.dart';
import 'package:dyd/feature/lucky-card/screen/lucky_card_screen.dart';
import 'package:dyd/feature/profile/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final landingController = Get.put(LandingController());
    List<Widget> screens = [
      HomeScreen(),
      LuckyCardScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    final activeSvgColor =
        ColorFilter.mode(AppPalette.darkViolet, BlendMode.srcIn);
    return Scaffold(
      body: Obx(() => screens[landingController.kCurrentScreenIndex.value]),
      bottomNavigationBar: Obx(() => Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppPalette.lightGrey2)),
            child: BottomNavigationBar(
              onTap: (int index) =>
                  landingController.fChangeCurrentScreenIndex(index),
              elevation: 5,
              currentIndex: landingController.kCurrentScreenIndex.value,
              selectedLabelStyle: TypoDarkViolet.darkViolet50015,
              unselectedLabelStyle: LightGreyTypo.lightGrey50015,
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppPalette.white,
              selectedIconTheme: IconThemeData(color: AppPalette.darkViolet),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(ImageHelper.bnHome),
                  activeIcon: SvgPicture.asset(
                    ImageHelper.bnHome,
                    colorFilter: activeSvgColor,
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(ImageHelper.bnTag),
                    activeIcon: SvgPicture.asset(
                      ImageHelper.bnTag,
                      colorFilter: activeSvgColor,
                    ),
                    label: "Lucky Card"),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(ImageHelper.bnCart),
                  activeIcon: SvgPicture.asset(
                    ImageHelper.bnCart,
                    colorFilter: activeSvgColor,
                  ),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(ImageHelper.bnProfile),
                    activeIcon: SvgPicture.asset(
                      ImageHelper.bnProfile,
                      colorFilter: activeSvgColor,
                    ),
                    label: "Profile"),
              ],
            ),
          )),
    );
  }
}
