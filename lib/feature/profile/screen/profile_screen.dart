import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/typo/yellow_typo.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/feature/lucky-card/screen/lucky_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../lucky-card/screen/discount_card_screen.dart';
import '../../notification/screen/notification_screen.dart';
import '../../order/screen/my_order_screen.dart';
import '../../product/screen/wishlist_product_screen.dart';
import '../widget/profile_count_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> profileList = [
      {"title": "My Orders", "icon": Icons.shopping_bag},
      {"title": "Notifications", "icon": Icons.notifications},
      {"title": "Wishlist", "icon": Icons.favorite},
      {"title": "Discount Card", "icon": Icons.security},
      {"title": "Lucky Card", "icon": Icons.airplane_ticket},
      {"title": "Help & Support", "icon": Icons.help_outline},
      {"title": "Privacy policy", "icon": Icons.description},
    ];
    Widget dividerWidget() => Divider(
          color: AppPalette.lightGrey2,
        );
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TypoWhite.white70018),
        backgroundColor: AppPalette.indigo,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppPalette.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildProfileDetailWidget(),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  color: AppPalette.white,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      buildProductStatusCountWidget(),
                      dividerWidget(),
                      Expanded(
                          child: ListView.separated(
                              itemBuilder: (ctx, index) =>
                                  buildNavigationCardWidget(
                                      context, profileList, index),
                              separatorBuilder: (context, index) =>
                                  dividerWidget(),
                              itemCount: profileList.length))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: AppPalette.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 25,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          foregroundColor: AppPalette.lightViolet,
                          child:
                              Icon(Icons.logout, color: AppPalette.darkViolet),
                        ),
                        Text("Are you sure you want to logout?",
                            style: TypoDarkGrey.darkGrey50016),
                        Row(
                          spacing: 25,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CMaterialButton(
                              elevation: 0,
                              minWidth: 120,
                              height: 40,
                              onPressed: () => Get.back(),
                              color: AppPalette.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side:
                                      BorderSide(color: AppPalette.darkViolet)),
                              child: Text("No"),
                            ),
                            CGradientMaterialButton(
                                height: 40,
                                minWidth: 120,
                                elevation: 0,
                                child: Text("Yes", style: TypoWhite.white50016),
                                onPressed: () {})
                          ],
                        )
                      ],
                    ),
                  ));
        },
        child: Card(
          elevation: 0,
          color: AppPalette.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppPalette.red),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 5,
              children: [
                Icon(Icons.logout, color: AppPalette.red),
                Text("Logout", style: TypoRed.red50015)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNavigationCardWidget(
      BuildContext context, List<Map<String, dynamic>> profileList, int index) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          context.pushFadedTransition(MyOrderScreen());
          return;
        }
        if (index == 1) {
          context.pushFadedTransition(NotificationScreen());
          return;
        }
        if (index == 2) {
          context.pushFadedTransition(WishlistProductScreen());
          return;
        }
        if (index == 3) {
          context.pushFadedTransition(DiscountCardScreen());
          return;
        }
        if (index == 4) {
          context.pushFadedTransition(LuckyCardScreen());
          return;
        }
      },
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              index != 4
                  ? Icon(
                      profileList[index]["icon"],
                      color: AppPalette.darkViolet,
                    )
                  : FaIcon(FontAwesomeIcons.ticket,
                      color: AppPalette.darkViolet),
              Spacing.horizontalSpace(15),
              Text(
                profileList[index]["title"],
                style: TypoBlack.black40016,
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: AppPalette.black,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildProductStatusCountWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileCountWidget(
            icon: Icons.shopping_bag,
            title: "Count",
            count: "12",
          ),
          ProfileCountWidget(
            icon: Icons.favorite,
            title: "Wishlist",
            count: "24",
          ),
          ProfileCountWidget(
            icon: Icons.airplane_ticket,
            title: "Discount Count",
            count: "12",
            type: "faIcon",
          ),
        ],
      ),
    );
  }

  Padding buildProfileDetailWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: SizedBox(
              height: 75,
              width: 75,
              child: CCachedNetworkImage(
                  imageLink:
                      "https://cdn.pixabay.com/photo/2022/07/31/21/27/little-boy-7356918_1280.jpg"),
            ),
          ),
          Spacing.verticalSpace(8),
          Text("Sarah Johnson", style: TypoWhite.white70024),
          Text("gamil@gmail.com", style: TypoYellow.yellow50015),
          Spacing.verticalSpace(10),
          CMaterialButton(
              minWidth: 148,
              height: 40,
              color: AppPalette.yellow,
              child: Text(
                "Edit Profile",
                style: TypoPrimary.primary60016,
              ),
              onPressed: () {})
        ],
      ),
    );
  }
}
