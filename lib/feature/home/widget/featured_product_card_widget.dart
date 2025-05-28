import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/feature/product/screen/product_detail_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';
import '../../../core/constant/text.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/widget/button-widget/c_material_button_widget.dart';
import '../../../core/widget/image-widget/cached_network_image.dart';

class FeaturedProductCardWidget extends StatefulWidget {
  const FeaturedProductCardWidget({super.key});

  @override
  State<FeaturedProductCardWidget> createState() =>
      _FeaturedProductCardWidgetState();
}

class _FeaturedProductCardWidgetState extends State<FeaturedProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushFadedTransition(ProductDetailScreen());
      },
      child: SizedBox(
        width: 280,
        child: Card(
          elevation: 0.4,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 144,
                  width: double.infinity,
                  child: CCachedNetworkImage(
                      imageLink:
                          "https://cdn.pixabay.com/photo/2018/01/30/12/43/no-person-3118684_1280.jpg",
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Premium Shoes",
                      style: TypoBlack.black60016,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "${ConstantText.rupeeSymbol}199\t\t",
                            style: TypoRed.red70018,
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${ConstantText.rupeeSymbol}210",
                                  style:
                                      LightGreyTypo.lightGrey40014LineThrough),
                            ],
                          ),
                        ),
                        CMaterialButton(
                          height: 30,
                          minWidth: 100,
                          color: AppPalette.yellow,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: Text("Buy Now"),
                          onPressed: () {},
                        )
                      ],
                    ),
                    Spacing.verticalSpace(10),
                    Text("Get it for ${ConstantText.rupeeSymbol}900",
                        style: GreenTypo.green40012)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
