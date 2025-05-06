import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/orange_typo.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/blue_typo.dart';

class HotDealHomeWidget extends StatelessWidget {
  const HotDealHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing.verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Today's Hot Deal", style: TypoBlack.black70018),
            Row(
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
          ],
        ),
        Spacing.verticalSpace(8),
        buildHotDealWidget(context)
      ],
    );
  }

  Card buildHotDealWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CCachedNetworkImage(
                    imageLink:
                        "https://cdn.pixabay.com/photo/2022/05/23/05/42/summer-7215310_1280.jpg"),
              ),
            ),
            Spacing.horizontalSpace(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sports shoes",
                  style: TypoBlack.black70016,
                  overflow: TextOverflow.ellipsis,
                ),
                RichText(
                  text: TextSpan(
                    text: "${ConstantText.rupeeSymbol}100 ",
                    style: TypoOrange.orange70018,
                    children: [
                      TextSpan(
                        text: "${ConstantText.rupeeSymbol}100",
                        style: LightGreyTypo.lightGrey40014LineThrough,
                      ),
                    ],
                  ),
                ),
                Spacing.verticalSpace(5),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      color: AppPalette.darkGrey,
                      size: 16,
                    ),
                    Spacing.horizontalSpace(5),
                    Text(
                      "2d 15min left",
                      style: TypoDarkGrey.darkGrey40014,
                    ),
                  ],
                ),
                Spacing.verticalSpace(10),
                SizedBox(
                  height: 8,
                  width: context.dynamicWidth(0.6),
                  child: LinearPercentIndicator(
                    percent: 0.7,
                    progressColor: AppPalette.blue,
                    lineHeight: 8,
                    barRadius: Radius.circular(10),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
