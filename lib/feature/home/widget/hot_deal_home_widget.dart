import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/orange_typo.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/model/hotdeals-model/hot_deals_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/blue_typo.dart';

class HotDealHomeWidget extends StatelessWidget {
  const HotDealHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    controller.fGetHotDeals();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacing.verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Hot Deal", style: TypoBlack.black70018),
          ],
        ),
        Spacing.verticalSpace(8),
        Obx(() {
          if (controller.kHotDealsList.isEmpty) {
            return Center(child: Text("No Hot Deals"));
          }
          return ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.kHotDealsList.length,
            separatorBuilder: (context, index) => Spacing.verticalSpace(10),
            itemBuilder: (context, index) {
              final hotDeal = controller.kHotDealsList[index];
              return buildHotDealWidget(context, hotDeal);
            },
          );
        })
      ],
    );
  }

  /// Builds a single Hot Deal card widget
  Widget buildHotDealWidget(BuildContext context, HotDealsModel hotDeal) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CCachedNetworkImage(
                    imageLink: hotDeal.image!.isEmpty
                        ? ""
                        : "$IMAGE_URL${hotDeal.image!}"),
              ),
            ),
            Spacing.horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotDeal.productName ?? '',
                    style: TypoBlack.black70016,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacing.verticalSpace(4),
                  RichText(
                    text: TextSpan(
                      text: "${ConstantText.rupeeSymbol}${hotDeal.salePrice} ",
                      style: TypoOrange.orange70018,
                      children: [
                        TextSpan(
                          text:
                              "${ConstantText.rupeeSymbol}${hotDeal.basePrice}",
                          style: LightGreyTypo.lightGrey40014LineThrough,
                        ),
                      ],
                    ),
                  ),
                  Spacing.verticalSpace(5),
                  Row(
                    children: [
                      Icon(Icons.access_time_filled,
                          color: AppPalette.darkGrey, size: 16),
                      Spacing.horizontalSpace(5),
                      Text("2d 15min left", style: TypoDarkGrey.darkGrey40014),
                    ],
                  ),
                  Spacing.verticalSpace(10),
                  LinearPercentIndicator(
                    percent: 0.7,
                    progressColor: AppPalette.blue,
                    backgroundColor: Colors.grey.shade300,
                    lineHeight: 8,
                    barRadius: Radius.circular(10),
                    width: context.dynamicWidth(0.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
