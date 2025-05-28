import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:dyd/feature/lucky-card/screen/discount_cards_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    homeController.fGetRecentWinnerList();
    homeController.fGetAvailableDraws();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTimerWidget(),
            // Spacing.verticalSpace(10),
            // Text("Your Coupon", style: TypoBlack.black70018),
            // CouponCardWidgetHome(),
            Spacing.verticalSpace(10),
            Text("Recent Winner", style: TypoBlack.black70018),

            Spacing.verticalSpace(10),

            Obx(() {
              if (homeController.kRecentWinnerList.isEmpty) {
                return Center(child: Text("No Recent Winners"));
              }
              return SizedBox(
                height: 130,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.kRecentWinnerList.length,
                    itemBuilder: (BuildContext context, index) {
                      final winners = homeController.kRecentWinnerList[index];
                      return Card(
                        color: AppPalette.white,
                        child: SizedBox(
                          height: 108,
                          // width: 200,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CNetworkImageWithTextWidget(
                                      height: 40,
                                      width: 40,
                                      imageLink: winners.image.isEmpty
                                          ? 'https://cdn.pixabay.com/photo/2024/05/19/19/30/ai-generated-8773213_1280.png'
                                          : "$IMAGE_URL${winners.image}",
                                      name: "",
                                    ),
                                    Spacing.horizontalSpace(8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(winners.fullName,
                                            style:
                                                TypoDarkViolet.darkViolet60016),
                                        Text(
                                          "2 day ago",
                                          style: LightGreyTypo.lightGrey40012,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Spacing.verticalSpace(8),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.trophy,
                                      size: 13,
                                      color: AppPalette.darkViolet,
                                    ),
                                    Spacing.horizontalSpace(8),
                                    Text(winners.prize.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TypoDarkViolet.darkViolet60016),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),

            Spacing.verticalSpace(10),
            Text("Available Draw", style: TypoBlack.black70018),
            Spacing.verticalSpace(10),
            Obx(() {
              if (homeController.kAvailableDraws.isEmpty) {
                return Center(
                  child: Text("No Avaible Draws"),
                );
              }
              return SizedBox(
                height: 300,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.kAvailableDraws.length,
                    itemBuilder: (BuildContext context, index) {
                      final availableDraws =
                          homeController.kAvailableDraws[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Card(
                          elevation: 5,
                          color: AppPalette.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 8),
                            child: SizedBox(
                              width: 172,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CNetworkImageRectangularWithTextWidget(
                                    height: 140,
                                    width: 140,
                                    borderRadius: BorderRadius.circular(8),
                                    imageLink: availableDraws
                                            .prize.imageUrls[0].isEmpty
                                        ? ""
                                        : "$IMAGE_URL${availableDraws.prize.imageUrls[0]}",
                                    name: availableDraws.prize.name,
                                  ),
                                  Spacing.verticalSpace(5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(availableDraws.prize.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TypoBlack.black50015)),
                                  ),
                                  Spacing.verticalSpace(4),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Know more...",
                                        style: TypoDarkViolet.darkViolet50015,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: CMaterialButton(
                                        color: AppPalette.darkViolet,
                                        height: 40,
                                        child: Text(
                                          "Enter Draw",
                                          style: TypoWhite.white60014,
                                        ),
                                        onPressed: () {
                                          Get.to(DiscountCardListScreen());
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
            // SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: List.generate(3, (index) => buildDrawCardWidget()),
            //     ))
          ],
        ),
      ),
    );
  }

  //available draw
  Widget buildDrawCardWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        elevation: 5,
        color: AppPalette.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: SizedBox(
            width: 172,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CNetworkImageRectangularWithTextWidget(
                  height: 140,
                  width: 140,
                  borderRadius: BorderRadius.circular(8),
                  imageLink:
                      'https://cdn.pixabay.com/photo/2024/12/28/13/28/tram-9296118_1280.jpg',
                  name: '',
                ),
                Spacing.verticalSpace(5),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Grand Price", style: TypoBlack.black50015)),
                ),
                Spacing.verticalSpace(4),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Know more...",
                      style: TypoDarkViolet.darkViolet50015,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: CMaterialButton(
                      color: AppPalette.darkViolet,
                      height: 40,
                      child: Text(
                        "Enter Draw",
                        style: TypoWhite.white60014,
                      ),
                      onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //recent winner
  Card buildRecentWinnerWidget() {
    return Card(
      color: AppPalette.white,
      child: SizedBox(
        height: 108,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CNetworkImageWithTextWidget(
                    height: 40,
                    width: 40,
                    imageLink:
                        'https://cdn.pixabay.com/photo/2024/05/19/19/30/ai-generated-8773213_1280.png',
                    name: "",
                  ),
                  Spacing.horizontalSpace(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sarah M", style: TypoDarkViolet.darkViolet60016),
                      Text(
                        "2 day ago",
                        style: LightGreyTypo.lightGrey40012,
                      )
                    ],
                  )
                ],
              ),
              Spacing.verticalSpace(8),
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.trophy,
                    size: 13,
                    color: AppPalette.darkViolet,
                  ),
                  Spacing.horizontalSpace(8),
                  Text("iPhone", style: TypoDarkViolet.darkViolet60016),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimerWidget() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppPalette.primaryColor2,
                AppPalette.primaryColor1,
              ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Next Draw", style: TypoWhite.white50015),
            Spacing.verticalSpace(15),
            Align(
                alignment: Alignment.center,
                child: Text("05:30:00", style: TypoWhite.white80030))
          ],
        ),
      ),
    );
  }
}
