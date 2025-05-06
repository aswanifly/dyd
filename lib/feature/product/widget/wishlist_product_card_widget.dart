import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart';

class WishlistProductCardWidget extends StatelessWidget {
  final String productImage;
  final String productName;

  const WishlistProductCardWidget(
      {super.key, required this.productImage, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppPalette.lightGrey2,
      color: AppPalette.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CNetworkImageRectangularWithTextWidget(
              imageLink: productImage,
              fit: BoxFit.cover,
              width: double.infinity,
              name: "",
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                Text(productName,
                    style: TypoBlack.black50014,
                    overflow: TextOverflow.ellipsis),
                RichText(
                  text: TextSpan(
                    text: '${ConstantText.rupeeSymbol}100\t\t',
                    style: TypoRed.red70016,
                    children: [
                      TextSpan(
                          text: '${ConstantText.rupeeSymbol}150',
                          style: LightGreyTypo.lightGrey40014LineThrough)
                    ],
                  ),
                ),
                Text("In Stock", style: GreenTypo.green40012),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: CMaterialButton(
              height: 40,
              color: AppPalette.darkViolet,
              child: Text("Add to cart", style: TypoWhite.white70016),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
