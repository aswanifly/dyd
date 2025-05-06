import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/home/widget/coupon_card_widget_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    List.generate(3, (index) => buildRecentWinnerWidget()),
              ),
            ),
            Spacing.verticalSpace(10),
            Text("Available Draw", style: TypoBlack.black70018),
            Spacing.verticalSpace(10),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) => buildDrawCardWidget()),
                ))
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
