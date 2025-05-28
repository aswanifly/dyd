import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/feature/product/screen/product_detail_screen.dart';
import 'package:dyd/model/wish-list-model/wish_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';
import '../../../core/widget/image-widget/c_circular_cached_image_widget.dart';

class WishlistProductCardWidget extends StatelessWidget {
  WishListProductModel wishListProductModel;

  WishlistProductCardWidget({super.key, required this.wishListProductModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ProductDetailScreen(
            productId: "${wishListProductModel.product?.id}"));
      },
      child: Stack(children: [
        Card(
          elevation: 4,
          shadowColor: AppPalette.lightGrey2,
          color: AppPalette.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CNetworkImageRectangularWithTextWidget(
                  imageLink: (wishListProductModel.product?.image?.isNotEmpty ??
                          false)
                      ? "$IMAGE_URL${wishListProductModel.product!.image}"
                      : "https://cdn.pixabay.com/photo/2024/10/29/07/21/headphones-9158344_1280.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  name: "",
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(wishListProductModel.product?.productName ?? 'unknow',
                        style: TypoBlack.black50014,
                        overflow: TextOverflow.ellipsis),
                    RichText(
                      text: TextSpan(
                        text:
                            '${ConstantText.rupeeSymbol}${wishListProductModel.product!.salePrice}',
                        style: TypoRed.red70016,
                        children: [
                          TextSpan(
                              text:
                                  '${ConstantText.rupeeSymbol}${wishListProductModel.product!.basePrice}',
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
                  onPressed: () async {
                    ProductController productController =
                        Get.put(ProductController());
                    final model = productController.kProductDetailModel.value!;
                    final updatedModel =
                        model.copyWith(isAddedToCard: true, qty: model.qty + 1);
                    productController.kProductDetailModel(updatedModel);
                    await productController.fAddProductToCart();
                  },
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: 5,
            right: 2,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                )))
      ]),
    );
  }
}
