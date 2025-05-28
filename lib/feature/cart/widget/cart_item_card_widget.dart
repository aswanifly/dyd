import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/config/spacing/static_spacing_helper.dart';
import '../../../core/config/theme/app_palette.dart';
import '../../../core/constant/text.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/typo/dark_violet_typo.dart';
import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart';

class CartItemCardWidgetWithCountButton extends StatelessWidget {
  const CartItemCardWidgetWithCountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: AppPalette.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CNetworkImageRectangularWithTextWidget(
              name: "",
              height: 80,
              width: 80,
              borderRadius: BorderRadius.circular(8),
              imageLink:
                  "https://cdn.pixabay.com/photo/2022/06/21/21/15/audio-7276511_1280.jpg",
            ),
            Spacing.horizontalSpace(10),
            buildSecondHalf()
          ],
        ),
      ),
    );
  }

  Expanded buildSecondHalf() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacing.verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                "Cycle",
                style: TypoBlack.black70016,
                overflow: TextOverflow.ellipsis,
              )),
              FaIcon(
                FontAwesomeIcons.trashCan,
                size: 20,
                color: Colors.red,
              )
            ],
          ),
          Spacing.verticalSpace(10),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${ConstantText.rupeeSymbol}299",
                  style: TypoBlack.black60016,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.remove_circle_outline,
                color: AppPalette.darkViolet,
                size: 30,
              ),
              Spacing.horizontalSpace(8),
              Text("1", style: TypoDarkViolet.darkViolet60016),
              Spacing.horizontalSpace(8),
              Icon(
                Icons.add_circle,
                color: AppPalette.darkViolet,
                size: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}

class CartItemCardWidgetWithOutCountButton extends StatelessWidget {
  const CartItemCardWidgetWithOutCountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: AppPalette.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CNetworkImageRectangularWithTextWidget(
              name: "",
              height: 80,
              width: 80,
              borderRadius: BorderRadius.circular(8),
              imageLink:
                  "https://cdn.pixabay.com/photo/2014/09/24/14/29/macbook-459196_1280.jpg",
            ),
            Spacing.horizontalSpace(10),
            buildSecondHalf()
          ],
        ),
      ),
    );
  }

  Expanded buildSecondHalf() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                "Cycle",
                style: TypoBlack.black70016,
                overflow: TextOverflow.ellipsis,
              )),
              FaIcon(
                FontAwesomeIcons.trashCan,
                size: 20,
                color: Colors.red,
              )
            ],
          ),
          Spacing.verticalSpace(5),
          Text("Lucky Draw", style: LightGreyTypo.lightGrey40014),
          Spacing.verticalSpace(7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "${ConstantText.rupeeSymbol}299",
                  style: TypoBlack.black60016,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text("Know more...", style: TypoDarkViolet.darkViolet50015)
            ],
          )
        ],
      ),
    );
  }
}
