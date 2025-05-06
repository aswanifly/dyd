import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:dyd/feature/product/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/typo/black_typo.dart';

class ShopByCatHomeWidget extends StatelessWidget {
  const ShopByCatHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    List<Map<String, dynamic>> categoryListIcons = [
      {
        "name": "Fashion",
        "grad1": AppPalette.fashionColor1,
        "grad2": AppPalette.fashionColor2,
        "icon": ImageHelper.fashionSVG,
      },
      {
        "name": "Mobile",
        "grad1": AppPalette.mobileColor1,
        "grad2": AppPalette.mobileColor2,
        "icon": ImageHelper.mobileSVG,
      },
      {
        "name": "Audio",
        "grad1": AppPalette.audioColor1,
        "grad2": AppPalette.audioColor2,
        "icon": ImageHelper.audioSVG,
      },
      {
        "name": "Laptop",
        "grad1": AppPalette.laptopColor1,
        "grad2": AppPalette.laptopColor2,
        "icon": ImageHelper.laptopSVG,
      },
      {
        "name": "Home",
        "grad1": AppPalette.homeColor1,
        "grad2": AppPalette.homeColor2,
        "icon": ImageHelper.homeSVG,
      },
      {
        "name": "Deals",
        "grad1": AppPalette.dealColor1,
        "grad2": AppPalette.dealColor2,
        "icon": ImageHelper.dealSVG,
      },
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shop by Category", style: TypoBlack.black70018),
        Spacing.verticalSpace(5),
        Obx(() => homeController.kShoppingCategoryLoading.value ==
                Status.loading
            ? Center(
                child: Text("Loading...", style: TypoBlack.black40014),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController.kHomeShoppingCategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10, // Adjust spacing if needed
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final categoryModel =
                        homeController.kHomeShoppingCategoryList[index];
                    return GestureDetector(
                      onTap: () {
                        // if (index == 0) {
                        context.pushFadedTransition(
                            ProductListScreen(categoryId: categoryModel.id));
                        // }
                      },
                      child: buildCategoryIconsWidget(
                        imagePath: categoryListIcons[index]["icon"],
                        gradColor1: categoryListIcons[index]["grad1"],
                        gradColor2: categoryListIcons[index]["grad2"],
                        name: categoryModel.category,
                      ),
                    );
                  },
                ),
              )),
      ],
    );
  }

  Widget buildCategoryIconsWidget(
      {required String name,
      required String imagePath,
      required Color gradColor1,
      required Color gradColor2}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 60,
          width: 60,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(colors: [gradColor1, gradColor2])),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SvgPicture.asset(
              imagePath,
              height: 25,
              width: 35,
            ),
          ),
        ),
        Text(
          name,
          style: TypoBlack.black50012,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

// void fGetValuesFromMap(String value){
//   List<Map<String, dynamic>> categoryListIcons = [
//     {
//       "name": "Fashion",
//       "grad1": AppPalette.fashionColor1,
//       "grad2": AppPalette.fashionColor2,
//       "icon": ImageHelper.fashionSVG,
//     },
//     {
//       "name": "Mobile",
//       "grad1": AppPalette.mobileColor1,
//       "grad2": AppPalette.mobileColor2,
//       "icon": ImageHelper.mobileSVG,
//     },
//     {
//       "name": "Audio",
//       "grad1": AppPalette.audioColor1,
//       "grad2": AppPalette.audioColor2,
//       "icon": ImageHelper.audioSVG,
//     },
//     {
//       "name": "Laptop",
//       "grad1": AppPalette.laptopColor1,
//       "grad2": AppPalette.laptopColor2,
//       "icon": ImageHelper.laptopSVG,
//     },
//     {
//       "name": "Home",
//       "grad1": AppPalette.homeColor1,
//       "grad2": AppPalette.homeColor2,
//       "icon": ImageHelper.homeSVG,
//     },
//     {
//       "name": "Deals",
//       "grad1": AppPalette.dealColor1,
//       "grad2": AppPalette.dealColor2,
//       "icon": ImageHelper.dealSVG,
//     },
//   ];
//   final value = categoryListIcons.any((item)=>item[]);;
//   if(categoryListIcons.where())
// }
}
