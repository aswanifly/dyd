import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/feature/product/screen/product_detail_screen.dart';
import 'package:dyd/model/product-model/product_model.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel productModel;

  const ProductCardWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushFadedTransition(ProductDetailScreen(
        productId: productModel.id,
      )),
      child: Card(
        elevation: 4,
        shadowColor: AppPalette.lightGrey2,
        color: AppPalette.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CNetworkImageRectangularWithTextWidget(
                imageLink: "",
                fit: BoxFit.cover,
                width: double.infinity,
                name: productModel.productName,
                color: AppPalette.lightIndigo,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    productModel.productName,
                    style: TypoBlack.black50014,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    productModel.description,
                    maxLines: 2,
                    style: TypoBlack.black40012,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
