import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/utils/date_utils.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/feature/lucky-card/screen/lucky_card_screen.dart';
import 'package:dyd/feature/order/widget/order_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/loader/circular_progress_loader.dart';
import '../controller/discount_card_controller.dart';
import '../widget/dashed_line_widget.dart';
import '../widget/lucky_chip_widget.dart';

class DiscountCardListScreen extends StatefulWidget {
  const DiscountCardListScreen({super.key});

  @override
  State<DiscountCardListScreen> createState() => _DiscountCardListScreenState();
}

class _DiscountCardListScreenState extends State<DiscountCardListScreen> {
  final controller = Get.put<CouponCardController>(CouponCardController());

  @override
  void initState() {
    controller.fGetDiscountCard();
    controller.fGetDiscountCardsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.whiteShade,
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text("Discount Card"),
      ),
      body: Obx(() {
        if (controller.kDiscountCardLoading.value == Status.loading) {
          return const CLoadingCircularLoader();
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              // Filter Chips
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["All", "Active", "Expired"].map((type) {
                      bool isActive = controller.discountCardFilters.value ==
                          type.toLowerCase();
                      return GestureDetector(
                        onTap: () {
                          controller.discountCardFilters.value =
                              type.toLowerCase();
                          controller.fGetDiscountCardsList();
                        },
                        child: LuckyChipWidget(
                          title: type,
                          isActive: isActive,
                        ),
                      );
                    }).toList(),
                  )),

              const SizedBox(height: 10),

              // Top card
              Obx(() {
                if (controller.kDiscountInfoLoading.value == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.kDiscountInfoLoading.value ==
                    Status.error) {
                  return const Center(
                      child: Text('Failed to load discount cards'));
                } else if (controller.kDiscountInfoList.isEmpty) {
                  return const Center(
                      child: Text('No discount cards available'));
                }

                final topCard = controller.kDiscountInfoList.first;
                return Card(
                  color: AppPalette.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppPalette.darkGrey2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(topCard.name, style: TypoPrimary.primary70016),
                            Text(
                              "Valid until ${DateFormatUtil.convertIsoToMonthAndDay(topCard.endDate)}",
                              style: LightGreyTypo.lightGrey40014,
                            ),
                            Text(
                              "${ConstantText.rupeeSymbol}${topCard.price}",
                              style: TypoBlack.black50016,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CGradientMaterialButton(
                              onPressed: () {
                                controller.checkActiveDiscountCard(context,
                                    fromScreen: "discountcard");
                              },
                              height: 40,
                              minWidth: 100,
                              child:
                                  Text("Buy now", style: TypoWhite.white50015),
                            ),
                            const SizedBox(height: 5),
                            const Text("Know more.."),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 10),

              // Purchased Discount Cards List
              Expanded(
                child: Obx(() {
                  if (controller.kDiscountCardsList.isEmpty) {
                    return const Center(child: Text('No cards found.'));
                  }
                  return ListView.builder(
                    itemCount: controller.kDiscountCardsList.length,
                    itemBuilder: (context, index) {
                      final discount = controller.kDiscountCardsList[index];
                      return buildDiscountCard(discount);
                    },
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildCardDetailWidget(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("$name:\t\t\t", style: TypoDarkGrey.darkGrey40014),
        Text(value, style: TypoDarkGrey.darkGrey60014)
      ],
    );
  }

  Row buildCartAndGoToCartButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 48,
          width: 140,
          child: Card(
            elevation: 0,
            color: AppPalette.darkViolet,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.remove,
                  color: AppPalette.white,
                  size: 20,
                ),
                Text(
                  "1",
                  style: TypoWhite.white50015,
                ),
                Icon(
                  Icons.add,
                  color: AppPalette.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        CMaterialButton(
          height: 40,
          minWidth: 140,
          color: AppPalette.darkViolet,
          child: Text(
            "Buy now ${ConstantText.rupeeSymbol}100",
            style: TypoWhite.white50015,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildDiscountCard(discount) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: AppPalette.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(discount.bookingId, style: TypoBlack.black40012),
                    Text("Scan to validate",
                        style: LightGreyTypo.lightGrey40012),
                  ],
                ),
                const SizedBox(height: 10),
                DashedLineWidget(color: AppPalette.lightGrey, noOfLines: 30),
                const SizedBox(height: 10),
                buildCardDetailWidget(
                    "Discount Coupon no.", discount.bookingId ?? "N/A"),
                buildCardDetailWidget(
                    "Exp. date", discount.discountCardDetails.endDate),
                // buildCardDetailWidget(
                //     "Exp. time", discount.expiryTime ?? "10:00PM"),
                // const SizedBox(height: 10),
                Text("Discount", style: LightGreyTypo.lightGrey40012),
                Row(
                  children: [
                    Card(
                      color: AppPalette.primaryColor1,
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: Text(
                            "${discount.discountCardDetails.discountPercent}% OFF",
                            style: TypoWhite.white50016),
                      ),
                    ),
                    const Spacer(),
                    Chip(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      label: Text(discount.discountCardDetails.status,
                          // ? "Active"
                          // : "InActive",
                          style: LightGreyTypo.lightGrey50015),
                      backgroundColor: AppPalette.lightGrey2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                colors: [AppPalette.mobileColor1, AppPalette.dealColor2],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
