import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart'
    show CNetworkImageRectangularWithTextWidget;
import '../widget/dashed_line_widget.dart';
import '../widget/lucky_chip_widget.dart';

class LuckyCardScreen extends StatelessWidget {
  const LuckyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.whiteShade,
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text("Lucky Card"),
      ),
      body: Padding(
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("#SJDVNJKS", style: TypoBlack.black40012),
                            Chip(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: AppPalette.transparent)),
                                color: WidgetStatePropertyAll(
                                    AppPalette.lightGreen),
                                elevation: 0,
                                label: Text(
                                  "Active",
                                  style: GreenTypo.green50016,
                                ))
                          ],
                        ),
                        Spacing.verticalSpace(10),
                        DashedLineWidget(),
                        Spacing.verticalSpace(10),
                        Row(
                          children: [
                            CNetworkImageRectangularWithTextWidget(
                              height: 120,
                              width: 120,
                              borderRadius: BorderRadius.circular(8),
                              name: "",
                              imageLink:
                                  "https://cdn.pixabay.com/photo/2025/03/29/10/59/ryoan-ji-9500830_1280.jpg",
                            ),
                            Spacing.horizontalSpace(15),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                buildCardDetailWidget("Ticket no.", "123334"),
                                buildCardDetailWidget(
                                    "Draw date", "Feb 15, 2024"),
                                buildCardDetailWidget("Draw time", "10:00PM"),
                              ],
                            )),
                          ],
                        ),
                        Spacing.verticalSpace(10),
                        Divider(),
                        Row(
                          children: [
                            Text("For more Winning Chance",
                                style: LightGreyTypo.lightGrey50016),
                            Spacer(),
                            CMaterialButton(
                                height: 32,
                                minWidth: 92,
                                color: AppPalette.darkViolet,
                                child: Text(
                                  "Buy more",
                                  style: TypoWhite.white50016,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      showDragHandle: true,
                                      backgroundColor: AppPalette.whiteShade,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  spacing: 10,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        border: Border.all(
                                                            color: AppPalette
                                                                .darkGrey2),
                                                        gradient:
                                                            LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                            AppPalette
                                                                .blueishWhiteShade1,
                                                            AppPalette
                                                                .blueishWhiteShade2,
                                                          ],
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15,
                                                                vertical: 20),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          spacing: 15,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                CNetworkImageRectangularWithTextWidget(
                                                                  height: 80,
                                                                  width: 80,
                                                                  imageLink:
                                                                      "https://cdn.pixabay.com/photo/2025/03/29/10/59/ryoan-ji-9500830_1280.jpg",
                                                                  name: "",
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                Spacing
                                                                    .horizontalSpace(
                                                                        10),
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    spacing: 5,
                                                                    children: [
                                                                      Text(
                                                                          "Win Iphone 15 pro",
                                                                          style:
                                                                              TypoBlack.black70024),
                                                                      Text(
                                                                          "Iphone",
                                                                          style:
                                                                              LightGreyTypo.lightGrey40014)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Card(
                                                              color: AppPalette
                                                                  .white,
                                                              elevation: 0,
                                                              margin: EdgeInsets
                                                                  .zero,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        10),
                                                                child: Row(
                                                                  spacing: 10,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .access_time,
                                                                      color: AppPalette
                                                                          .darkGrey,
                                                                    ),
                                                                    Text(
                                                                        "Draw ends in: 10d",
                                                                        style: TypoBlack
                                                                            .black40014)
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacing.verticalSpace(10),
                                                    Text("Terms & Condition",
                                                        style: TypoBlack
                                                            .black60016),
                                                    Text("•\tTerms 1 is Lorem",
                                                        style: TypoBlack
                                                            .black40014),
                                                    Text("•\tTerms 1 is Lorem",
                                                        style: TypoBlack
                                                            .black40014),
                                                    Text("•\tTerms 1 is Lorem",
                                                        style: TypoBlack
                                                            .black40014),
                                                    Text("Read more",
                                                        style: TypoDarkViolet
                                                            .darkViolet50016),
                                                    Spacing.verticalSpace(10),
                                                    buildCartAndGoToCartButtonWidget(
                                                        context),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                })
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
      ),
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
