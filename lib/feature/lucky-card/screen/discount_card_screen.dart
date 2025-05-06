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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/loader/circular_progress_loader.dart';
import '../controller/discount_card_controller.dart';
import '../widget/dashed_line_widget.dart';
import '../widget/lucky_chip_widget.dart';

class DiscountCardScreen extends StatefulWidget {
  const DiscountCardScreen({super.key});

  @override
  State<DiscountCardScreen> createState() => _DiscountCardScreenState();
}

class _DiscountCardScreenState extends State<DiscountCardScreen> {
  final controller = Get.find<CouponCardController>();

  @override
  void initState() {
    controller.fGetDiscountInfo();
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
      body: Obx(() => controller.kDiscountInfoLoading.value == Status.loading
          ? CLoadingCircularLoader()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LuckyChipWidget(
                        title: "All",
                        isActive: true,
                      ),
                      LuckyChipWidget(
                        title: "Active",
                        isActive: false,
                      ),
                      LuckyChipWidget(
                        title: "Complete",
                        isActive: false,
                      ),
                    ],
                  ),
                  Spacing.verticalSpace(10),
                  //discount cards
                  Obx(() => controller.kDiscountInfoList.isEmpty
                      ? SizedBox()
                      : Card(
                          color: AppPalette.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: AppPalette.darkGrey2)),
                          child: SizedBox(
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.kDiscountInfoList[0].name,
                                          style: TypoPrimary.primary70025),
                                      Text("Valid until ${DateFormatUtil.convertIsoToMonthAndDay(controller.kDiscountInfoList[0].endDate)}",
                                          style: LightGreyTypo.lightGrey40014),
                                      // Spacing.verticalSpace(8),
                                      Text(
                                        "${ConstantText.rupeeSymbol}${controller.kDiscountInfoList[0].price}",
                                        style: TypoBlack.black50016,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CGradientMaterialButton(
                                        onPressed: () {},
                                        height: 40,
                                        minWidth: 100,
                                        child: Text("Buy now",
                                            style: TypoWhite.white50015),
                                      ),
                                      Text("Know more..")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  Spacing.verticalSpace(10),
                  //purchased cards
                  Card(
                    elevation: 0,
                    shadowColor: AppPalette.lightGrey2,
                    margin: EdgeInsets.zero,
                    color: AppPalette.white,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Spacing.verticalSpace(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("#SJDVNJKS",
                                      style: TypoBlack.black40012),
                                  Text("Scan to validate",
                                      style: LightGreyTypo.lightGrey40012)
                                ],
                              ),
                              Spacing.verticalSpace(10),
                              DashedLineWidget(
                                color: AppPalette.lightGrey,
                                noOfLines: 30,
                              ),
                              Spacing.verticalSpace(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 10,
                                children: [
                                  buildCardDetailWidget(
                                      "Discount Coupon no.", "123334"),
                                  buildCardDetailWidget(
                                      "Exp. date", "Feb 15, 2024"),
                                  buildCardDetailWidget("Exp. time", "10:00PM"),
                                ],
                              ),
                              Spacing.verticalSpace(10),
                              Text("Discount",
                                  style: LightGreyTypo.lightGrey40012),
                              Row(
                                children: [
                                  Card(
                                    margin: EdgeInsets.zero,
                                    elevation: 0,
                                    color: AppPalette.primaryColor1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 6),
                                      child: Text(
                                        "20%\tOFF",
                                        style: TypoWhite.white50016,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Chip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: AppPalette.transparent)),
                                      color: WidgetStatePropertyAll(
                                          AppPalette.lightGrey2),
                                      elevation: 0,
                                      label: Text("Active",
                                          style: LightGreyTypo.lightGrey50015))
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppPalette.mobileColor1,
                                AppPalette.dealColor2
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: 6,
                  //     itemBuilder: (ctx, index) {
                  //       return ;
                  //     },
                  //   ),
                  // )
                ],
              ),
            )),
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
}
