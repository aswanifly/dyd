import 'package:flutter/material.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/constant/text.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/dark_grey_typo.dart';
import '../../../core/typo/dark_violet_typo.dart';
import '../../../core/typo/light_grey_typo.dart';
import '../../../core/typo/primary_typo.dart';
import '../../../core/typo/white_typo.dart';
import '../../../core/typo/yellow_typo.dart';
import '../../../core/widget/button-widget/c_material_button_widget.dart';
import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPalette.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Order #1234566",
                  style: TypoBlack.black40014,
                  overflow: TextOverflow.ellipsis,
                ),
                Text("March 25, 2025", style: LightGreyTypo.lightGrey40014)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CNetworkImageRectangularWithTextWidget(
                    height: 48,
                    width: 48,
                    borderRadius: BorderRadius.circular(12),
                    imageLink:
                        "https://cdn.pixabay.com/photo/2021/12/04/20/59/animal-6845972_1280.jpg",
                    name: ""),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Wireless Headphone",
                            style: TypoBlack.black70016,
                            overflow: TextOverflow.ellipsis),
                        Spacing.verticalSpace(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("${ConstantText.rupeeSymbol}900",
                                style: TypoPrimary.primary60016),
                            RichText(
                              text: TextSpan(
                                text: 'Qty:\t',
                                style: LightGreyTypo.lightGrey40014,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '2', style: TypoBlack.black50014),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: AppPalette.yellow.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Text("In Transit", style: TypoYellow.darkYellow60014),
              ),
            ),
            Text("Expected by April", style: TypoDarkGrey.darkGrey40014),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 40,
              children: [
                Expanded(
                  child: CMaterialButton(
                    elevation: 0,
                    height: 40,
                    color: AppPalette.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppPalette.darkViolet)),
                    child: Text("Track Order",
                        style: TypoDarkViolet.darkViolet70016),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: CMaterialButton(
                    elevation: 0,
                    height: 40,
                    color: AppPalette.darkViolet,
                    child: Text("Track Order", style: TypoWhite.white70016),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
