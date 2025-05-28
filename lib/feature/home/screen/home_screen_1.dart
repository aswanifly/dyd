import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/asset-image-path/asset_image_path.dart';
import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/white_typo.dart';
import '../../../core/widget/button-widget/c_material_button_widget.dart';
import '../../../core/widget/text-field-widget/search_text_field_widget.dart';
import '../widget/feature_home_widget.dart';
import '../widget/hot_deal_home_widget.dart';
import '../widget/shop_by_cat_home_widget.dart';

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> adList = [
      "https://cdn.pixabay.com/photo/2025/03/22/20/26/ai-generated-9487507_1280.png",
      "https://cdn.pixabay.com/photo/2023/12/30/11/22/monstera-8477880_1280.jpg",
      "https://cdn.pixabay.com/photo/2023/01/22/05/51/nature-7735653_1280.jpg",
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Spacing.verticalSpace(10),
            SizedBox(
              height: context.dynamicHeight(0.17),
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: adList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: adList[itemIndex],
                  ),
                ),
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
              ),
            ),
            Spacing.verticalSpace(15),
            //feature card
            FeatureHomeWidget(),
            //category
            ShopByCatHomeWidget(),
            //hot deal
            HotDealHomeWidget(),
            Spacing.verticalSpace(15),
            Row(
              children: [
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(colors: [
                        AppPalette.darkViolet,
                        AppPalette.lightViolet
                      ])),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(ImageHelper.dealSVG),
                        Spacing.verticalSpace(5),
                        Text("20% OFF", style: TypoWhite.white60018),
                        Spacing.verticalSpace(5),
                        Text("New User Special", style: TypoWhite.white40014),
                        CMaterialButton(
                          height: 30,
                          minWidth: 88,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Claim Now",
                            style: TypoBlack.black50014,
                          ),
                          onPressed: () {},
                          color: AppPalette.yellow,
                        )
                      ],
                    ),
                  ),
                ),
                Spacing.horizontalSpace(10),
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: LinearGradient(
                          colors: [AppPalette.yellow, AppPalette.darkYellow])),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.gift,
                          size: 30,
                          color: Colors.white,
                        ),
                        Spacing.verticalSpace(5),
                        Text("20% OFF", style: TypoWhite.white60018),
                        Spacing.verticalSpace(5),
                        Text("New User Special", style: TypoWhite.white40014),
                        CMaterialButton(
                          height: 30,
                          minWidth: 88,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Claim Now",
                            style: TypoBlack.black50014,
                          ),
                          onPressed: () {},
                          color: AppPalette.yellow,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
