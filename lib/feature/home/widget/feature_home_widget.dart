import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/custom_dailog/show_discount_card_dialog.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:dyd/feature/home/widget/featured_product_card_widget.dart';
import 'package:dyd/feature/lucky-card/controller/discount_card_controller.dart';
import 'package:dyd/feature/lucky-card/screen/discount_cards_list_screen.dart';
import 'package:dyd/feature/lucky-card/screen/lucky_card_screen.dart';
import 'package:dyd/feature/order/widget/order_summary_screen.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/feature/product/screen/product_detail_screen.dart';
import 'package:dyd/feature/product/screen/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/typo/black_typo.dart';
import '../../../core/typo/blue_typo.dart';

class FeatureHomeWidget extends StatefulWidget {
  const FeatureHomeWidget({super.key});

  @override
  State<FeatureHomeWidget> createState() => _FeatureHomeWidgetState();
}

class _FeatureHomeWidgetState extends State<FeatureHomeWidget> {
  ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    productController.fGetAllProductsList();
    super.initState();
  }

  ButtonStyle buildCommonButtonStyle(
      {required Color bgColor, required Color fgColor}) {
    return ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 48),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: bgColor,
      foregroundColor: fgColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Featured Products", style: TypoBlack.black70018),
              productController.kAllProductList.isEmpty
                  ? SizedBox()
                  : InkWell(
                      onTap: () {
                        context.pushFadedTransition(ProductListScreen());
                      },
                      child: Row(
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
                    ),
            ],
          );
        }),
        Spacing.verticalSpace(15),
        Obx(() {
          if (productController.kProductListLoading.value == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productController.kProductListLoading.value ==
              Status.error) {
            return Center(
              child: Column(
                children: [
                  const Text('Failed to load featured products'),
                  ElevatedButton(
                    onPressed: () => productController.fGetAllProductsList(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (productController.kAllProductList.isEmpty) {
            return const Center(child: Text('No featured products available'));
          }

          return SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productController.kAllProductList.length,
              itemBuilder: (context, index) {
                final product = productController.kAllProductList[index];
                return GestureDetector(
                  onTap: () {
                    context.pushFadedTransition(ProductDetailScreen(
                      productId: product.id,
                    ));
                  },
                  child: SizedBox(
                    width: 280,
                    child: Card(
                      elevation: 0.4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: SizedBox(
                              height: 144,
                              width: double.infinity,
                              child: CCachedNetworkImage(
                                imageLink: product.images.isEmpty ||
                                        product.images[0].isEmpty
                                    ? ""
                                    : "$IMAGE_URL${product.images.first}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.productName,
                                    style: TypoBlack.black60016),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            "${ConstantText.rupeeSymbol}${product.salePrice}\t\t",
                                        style: TypoRed.red70018,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  "${ConstantText.rupeeSymbol}${product.basePrice}",
                                              style: LightGreyTypo
                                                  .lightGrey40014LineThrough),
                                        ],
                                      ),
                                    ),
                                    CMaterialButton(
                                      height: 30,
                                      minWidth: 100,
                                      color: AppPalette.yellow,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Text("Buy Now"),
                                      onPressed: () async {
                                        final couponCardController =
                                            Get.find<CouponCardController>();
                                        bool isActive =
                                            await couponCardController
                                                .checkDiscountCardFromProductBuy(
                                                    context);

                                        if (isActive) {
                                          productController.fAddtoCart(
                                            productId: product.id,
                                            productName: product.productName,
                                            salePrice: product.salePrice,
                                            qyt: "1",
                                            discount: product.discount,
                                            basePrice: product.basePrice,
                                          );
                                        } else {
                                          showDiscountCardDialog(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                Spacing.verticalSpace(10),
                                Text(
                                  "Get it for ${ConstantText.rupeeSymbol}900",
                                  style: GreenTypo.green40012,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
