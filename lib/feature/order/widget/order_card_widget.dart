import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/feature/lucky-card/controller/discount_card_controller.dart';
import 'package:dyd/feature/lucky-card/screen/discount_cards_list_screen.dart';
import 'package:dyd/feature/order/screen/track_order_screen.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';

import 'package:dyd/model/order-model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  OrderModel orderModel;
  OrderCardWidget({super.key, required this.orderModel});

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
                  "Order #${orderModel.bookingId}",
                  style: TypoBlack.black40014,
                  overflow: TextOverflow.ellipsis,
                ),
                // Text("March 25, 2025", style: LightGreyTypo.lightGrey40014)
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
                    imageLink: orderModel.orderInfos.first.image.isEmpty
                        ? ""
                        : "$IMAGE_URL${orderModel.orderInfos.first.image}",
                    name: orderModel.orderInfos.first.productName),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                orderModel.orderInfos.first.productName.isEmpty
                                    ? "Product Name"
                                    : orderModel.orderInfos.first.productName,
                                style: TypoBlack.black70016,
                                overflow: TextOverflow.ellipsis),
                            // Text(
                            //   DateFormat('MMM dd, yyyy').format(
                            //       DateTime.parse(orderModel.createdAt!)),
                            // )
                          ],
                        ),
                        Spacing.verticalSpace(3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                "${ConstantText.rupeeSymbol}${orderModel.orderTotalAmount}",
                                style: TypoPrimary.primary60016),
                            RichText(
                              text: TextSpan(
                                text: 'Qty:\t',
                                style: LightGreyTypo.lightGrey40014,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: orderModel
                                          .orderInfos.first!.purchaseQuantity,
                                      style: TypoBlack.black50014),
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
                child: Text(orderModel.orderStatus,
                    style: TypoYellow.darkYellow60014),
              ),
            ),
            Text("Expected by 2 days", style: TypoDarkGrey.darkGrey40014),
            orderModel.orderStatus == "Confirmed" ||
                    orderModel.orderStatus == "InTransit" ||
                    orderModel.orderStatus == "Pending"
                ? Row(
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
                          onPressed: () {
                            Get.to(TrackOrderScreen(
                              orderId: orderModel.orderId,
                            ));
                          },
                        ),
                      ),
                      Expanded(
                        child: CMaterialButton(
                          elevation: 0,
                          height: 40,
                          color: AppPalette.darkViolet,
                          child: Text("Buy Again", style: TypoWhite.white70016),
                          onPressed: () async {
                            final couponCardController =
                                Get.find<CouponCardController>();
                            final productController =
                                Get.find<ProductController>();
                            bool isActive = await couponCardController
                                .checkDiscountCardFromProductBuy(context);

                            if (isActive) {
                              // productController.fAddtoCart(
                              //   productId: orderModel.orderId,
                              //   productName: product.productName,
                              //   salePrice: product.salePrice,
                              //   qyt: "1",
                              //   discount: product.discount,
                              //   basePrice: product.basePrice,
                              // );
                            } else {
                              Get.to(() => DiscountCardListScreen());
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : CGradientMaterialButton(
                    onPressed: () {},
                    child: Text("Buy Again", style: TypoWhite.white70016),
                  ),
          ],
        ),
      ),
    );
  }
}
