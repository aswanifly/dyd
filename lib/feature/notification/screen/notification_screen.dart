import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widget/notification_chip_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("Notification"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildFilterTypeWidget(),
          ColoredBox(
            color: AppPalette.lightIndigo,
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Clear All Notification",
                style: TypoPrimary.primary50014,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0.5,
                shadowColor: AppPalette.lightGrey2,
                color: AppPalette.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 10,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset(ImageHelper.notificationTrophy),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text("Congratulations! you won",
                              style: TypoBlack.black70016),
                          Text("You've won a ${ConstantText.rupeeSymbol}100",
                              style: TypoDarkGrey.darkGrey50014),
                          Text("2 hours ago", style: LightGreyTypo.lightGrey50012)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildFilterTypeWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 8,
          children: [
            NotificationChipWidget(
              title: "All",
              isActive: true,
            ),
            NotificationChipWidget(
              title: "Wins",
              isActive: false,
            ),
            NotificationChipWidget(
              title: "Tickets",
              isActive: false,
            ),
            NotificationChipWidget(
              title: "Account",
              isActive: false,
            ),
            NotificationChipWidget(
              title: "Promotion",
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
