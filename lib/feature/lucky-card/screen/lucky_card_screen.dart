import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/utils/date_utils.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/feature/lucky-card/controller/discount_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart'
    show CNetworkImageRectangularWithTextWidget;
import '../widget/dashed_line_widget.dart';
import '../widget/lucky_chip_widget.dart';

class LuckyCardScreen extends StatefulWidget {
  const LuckyCardScreen({super.key});

  @override
  State<LuckyCardScreen> createState() => _LuckyCardScreenState();
}

class _LuckyCardScreenState extends State<LuckyCardScreen> {
  final CouponCardController controller = Get.put(CouponCardController());

  @override
  void initState() {
    controller.fGetLuckyCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.whiteShade,
      appBar: const GradientAppBar(
        centerTitle: true,
        title: Text("Lucky Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ["All", "Active", "Completed"].map((type) {
                      bool isActive = controller.luckyFilterType.value ==
                          type.toLowerCase();
                      return GestureDetector(
                        onTap: () {
                          controller.luckyFilterType.value = type.toLowerCase();
                          controller.fGetLuckyCard();
                        },
                        child: LuckyChipWidget(
                          title: type,
                          isActive: isActive,
                        ),
                      );
                    }).toList(),
                  )),
              Spacing.verticalSpace(10),
              Obx(() {
                if (controller.kLuckyCardsList.isEmpty) {
                  return const Center(
                    child: Text("No lucky cards available"),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.kLuckyCardsList.length,
                  itemBuilder: (context, index) {
                    final luckyCard = controller.kLuckyCardsList[index];
                    return Card(
                      elevation: 0,
                      shadowColor: AppPalette.lightGrey2,
                      margin: EdgeInsets.zero,
                      color: AppPalette.white,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      luckyCard.ticketNumber!,
                                      style: TypoBlack.black40012,
                                    ),
                                    Chip(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: const BorderSide(
                                          color: AppPalette.transparent,
                                        ),
                                      ),
                                      color: const WidgetStatePropertyAll(
                                        AppPalette.lightGreen,
                                      ),
                                      elevation: 0,
                                      label: Text(
                                        luckyCard.status!,
                                        style: GreenTypo.green50016,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing.verticalSpace(10),
                                const DashedLineWidget(),
                                Spacing.verticalSpace(10),
                                Row(
                                  children: [
                                    CNetworkImageRectangularWithTextWidget(
                                        height: 120,
                                        width: 120,
                                        borderRadius: BorderRadius.circular(8),
                                        name: luckyCard.ticketNumber!,
                                        imageLink: luckyCard
                                                .discountCardImage!.isEmpty
                                            ? ""
                                            : "$IMAGE_URL${luckyCard.discountCardImage}"),
                                    Spacing.horizontalSpace(15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildCardDetailWidget(
                                            "Ticket no.",
                                            luckyCard.ticketNumber!,
                                          ),
                                          Spacing.verticalSpace(5),
                                          buildCardDetailWidget(
                                            "Draw date",
                                            DateFormat('MMM dd, yyyy').format(
                                                DateTime.parse(luckyCard
                                                    .drawExpiryDate!
                                                    .toIso8601String())),
                                          ),
                                          Spacing.verticalSpace(5),
                                          buildCardDetailWidget(
                                            "Draw time",
                                            DateFormat('h:mm a').format(
                                                DateTime.parse(luckyCard
                                                    .drawExpiryDate!
                                                    .toIso8601String())),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing.verticalSpace(10),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      "For more Winning Chance",
                                      style: LightGreyTypo.lightGrey50016,
                                    ),
                                    const Spacer(),
                                    CMaterialButton(
                                      height: 32,
                                      minWidth: 92,
                                      color: AppPalette.darkViolet,
                                      child: Text(
                                        "Buy more",
                                        style: TypoWhite.white50016,
                                      ),
                                      onPressed: () {
                                        controller.fGetTicketDetailInfo(
                                          context,
                                          luckyCard.id!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppPalette.mobileColor1,
                                  AppPalette.dealColor2,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardDetailWidget(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "$name:\t\t",
          style: TypoDarkGrey.darkGrey40014,
        ),
        Flexible(
          child: Text(
            value,
            style: TypoDarkGrey.darkGrey60014,
          ),
        ),
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
                Icon(Icons.remove, color: AppPalette.white, size: 20),
                Text("1", style: TypoWhite.white50015),
                Icon(Icons.add, color: AppPalette.white, size: 20),
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
