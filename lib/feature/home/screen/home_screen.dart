import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/widget/app-bar-widget/app-bar-widget.dart';
import 'home_screen_1.dart';
import 'home_screen_2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());

  @override
  void initState() {
    homeController.fCallFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        automaticallyImplyLeading: false,
        title: Obx(() {
          final isCouponScreen = homeController.kIsCouponScreen.value;
          return Container(
            height: 33,
            width: 220,
            decoration: BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              child: Row(
                children: [
                  //coupon
                  Expanded(
                      // flex: isCouponScreen ? 2 : 1,
                      child: Card(
                    color: isCouponScreen
                        ? AppPalette.darkViolet
                        : AppPalette.white,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: GestureDetector(
                        onTap: () => homeController.fToggleHomeScreen(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              // width: isCouponScreen ? 30 : 40,
                              child: Center(
                                  child: SvgPicture.asset(
                                ImageHelper.couponSVG,
                                colorFilter: ColorFilter.mode(
                                  isCouponScreen
                                      ? AppPalette.white
                                      : AppPalette.darkViolet,
                                  BlendMode
                                      .srcIn, // Ensures proper color application
                                ),
                              )),
                            ),
                            Text(
                              "Draws",
                              style: isCouponScreen
                                  ? TypoWhite.white60016
                                  : TypoDarkViolet.darkViolet60016,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  Spacing.horizontalSpace(2),
                  Expanded(
                      // flex: isCouponScreen ? 1 : 2,
                      child: Card(
                    color: !isCouponScreen
                        ? AppPalette.darkViolet
                        : AppPalette.white,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6))),
                    child: GestureDetector(
                      onTap: () => homeController.fToggleHomeScreen(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 30,
                            // width: !isCouponScreen ? 30 : 40,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.gift,
                                size: 20,
                                color: isCouponScreen
                                    ? AppPalette.darkViolet
                                    : AppPalette.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "Shopping",
                              style: !isCouponScreen
                                  ? TypoWhite.white60016
                                  : TypoDarkViolet.darkViolet60016,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          );
        }),
      ),
      body: Obx(() =>
          homeController.kIsCouponScreen.value ? HomeScreen2() : HomeScreen1()),
    );
  }
}
