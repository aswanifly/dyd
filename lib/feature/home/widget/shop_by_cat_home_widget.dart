import 'package:cached_network_image/cached_network_image.dart';
import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Shop by Category", style: TypoBlack.black70018),
          // Spacing.verticalSpace(5),
          Obx(() => homeController.kShoppingCategoryLoading.value ==
                  Status.loading
              ? Center(
                  child: Text("Loading...", style: TypoBlack.black40014),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(() {
                    if (homeController.kShoppingCategoryLoading.value ==
                        Status.loading) {
                      return Center(
                        child: Text("Loading...", style: TypoBlack.black40014),
                      );
                    }

                    final activeCategories = homeController
                        .kHomeShoppingCategoryList
                        .where((element) => element.isActive)
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: activeCategories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 8,
                          childAspectRatio: 0.9,
                        ),
                        itemBuilder: (context, index) {
                          final categoryModel = activeCategories[index];
                          return InkWell(
                            onTap: () {
                              context.pushFadedTransition(
                                ProductListScreen(categoryId: categoryModel.id),
                              );
                            },
                            child: buildCategoryIconsWidget(
                              imagePath: categoryModel.image.isEmpty
                                  ? ""
                                  : "$IMAGE_URL${categoryModel.image}",
                              name: categoryModel.category,
                            ),
                          );
                        },
                      ),
                    );
                  }),
                )),
        ],
      ),
    );
  }

  Widget buildCategoryIconsWidget({
    required String name,
    required String imagePath,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Image.asset(imagePath, fit: BoxFit.cover),
              errorWidget: (context, url, error) =>
                  Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
        ),
        // const SizedBox(height: 6),
        SizedBox(
          height: 36,
          child: Center(
            child: Text(
              name,
              style: TypoBlack.black50014.copyWith(height: 1.2),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              // maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
