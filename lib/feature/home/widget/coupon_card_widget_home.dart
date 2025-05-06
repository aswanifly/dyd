import 'package:flutter/material.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/constant/text.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/dark_violet_typo.dart';
import '../../../core/typo/light_grey_typo.dart';
import '../../../core/typo/white_typo.dart';
import '../../../core/widget/button-widget/c_material_button_widget.dart';

class CouponCardWidgetHome extends StatelessWidget {
  const CouponCardWidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Card(
                  color: AppPalette.darkViolet,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("20%", style: TypoWhite.white90024),
                      Text("Discount", style: TypoWhite.white60014),
                    ],
                  )),
            ),
            Spacing.horizontalSpace(10),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Apple Discount Card",
                            style: TypoBlack.black70016,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        CMaterialButton(
                          height: 36,
                          minWidth: 90,
                          color: AppPalette.darkViolet,
                          child: Text(
                            "ADD",
                            style: TypoWhite.white60016,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Text("Lucky Draw on Jan 15, 2024",
                        style: LightGreyTypo.lightGrey40014),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${ConstantText.rupeeSymbol}100",
                            style: TypoBlack.black60016),
                        Text(
                          "Know more...",
                          style: TypoDarkViolet.darkViolet50016,
                        )
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
