import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:dyd/feature/home/widget/featured_product_card_widget.dart';
import 'package:dyd/feature/product/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/typo/black_typo.dart';
import '../../../core/typo/blue_typo.dart';

class FeatureHomeWidget extends StatelessWidget {
  const FeatureHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Featured Products", style: TypoBlack.black70018),
            //show view all only when the category list is not 0(zero)
            Get.find<HomeController>().kHomeShoppingCategoryList.isEmpty
                ? SizedBox()
                : InkWell(
                    onTap: () {
                      String categoryId = Get.find<HomeController>()
                          .kHomeShoppingCategoryList[0]
                          .id;
                      context.pushFadedTransition(ProductListScreen(
                        categoryId: categoryId,
                      ));
                    },
                    child: Row(
                      children: [
                        Text("View All", style: TypoBlue.blue50014),
                        Spacing.horizontalSpace(5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppPalette.blue,
                          size: 15,
                        )
                      ],
                    ),
                  ),
          ],
        ),
        Spacing.verticalSpace(15),
        SizedBox(
          height: 280,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) => FeaturedProductCardWidget()),
        ),
      ],
    );
  }
}
