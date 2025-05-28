import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/utils/date_utils.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/feature/address/view-model/address_view_model.dart';
import 'package:dyd/feature/address/widgets/address_view.dart';
import 'package:dyd/feature/cart/widget/cart_item_card_widget.dart';
import 'package:dyd/feature/home/screen/home_screen.dart';
import 'package:dyd/feature/lucky-card/controller/discount_card_controller.dart';
import 'package:dyd/model/address-model/address_model.dart';
import 'package:dyd/model/coupon-model/discount_info_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class OrderSummaryScreen extends StatefulWidget {
  DiscountInfoModel discountInfoModel;
  OrderSummaryScreen({super.key, required this.discountInfoModel});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final price = int.tryParse(widget.discountInfoModel.price) ?? 0;
    final discountPercent =
        int.tryParse(widget.discountInfoModel.discountPercent) ?? 0;

    // Calculate discount amount
    final discountAmount = (price * discountPercent) ~/ 100;
    // Calculate total after discount
    final totalAfterDiscount = price - discountAmount;
    return Scaffold(
      appBar: GradientAppBar(title: Text("Order Summary")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Items", style: TypoBlack.black70018),
              Spacing.verticalSpace(10),
              Card(
                color: AppPalette.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CNetworkImageRectangularWithTextWidget(
                        name: "",
                        height: 80,
                        width: 80,
                        borderRadius: BorderRadius.circular(8),
                        imageLink: widget.discountInfoModel.image.isEmpty
                            ? "https://cdn.pixabay.com/photo/2014/09/24/14/29/macbook-459196_1280.jpg"
                            : "$IMAGE_URL${widget.discountInfoModel.image}",
                      ),
                      Spacing.horizontalSpace(10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.discountInfoModel.discountPercent}% OFF",
                              style: TypoBlack.black70016,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.discountInfoModel.name,
                                  style: TypoBlack.black70016,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ],
                            ),
                            Spacing.verticalSpace(5),
                            Text(
                              "Valid until ${DateFormatUtil.convertIsoToMonthAndDay(widget.discountInfoModel.endDate)}",
                              style: LightGreyTypo.lightGrey40014,
                            ),
                            Spacing.verticalSpace(7),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${ConstantText.rupeeSymbol}${widget.discountInfoModel.price}",
                                    style: TypoBlack.black60016,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text("Know more...",
                                    style: TypoDarkViolet.darkViolet50015)
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacing.verticalSpace(20),
              Card(
                elevation: 0,
                color: AppPalette.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppPalette.lightGrey2),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      buildSingleAmountWidget(
                          "Subtotal",
                          widget.discountInfoModel.price,
                          Icons.shopping_bag_outlined),
                      buildSingleAmountWidget(
                          "Delivery Fee", "0", Icons.delivery_dining_outlined),
                      buildSingleAmountWidget(
                          "Discount",
                          widget.discountInfoModel.discountPercent,
                          Icons.percent),
                      Divider(),
                      buildSingleAmountWidget("Total", "$totalAfterDiscount",
                          null, TypoBlack.black60016),
                    ],
                  ),
                ),
              ),
              Spacing.verticalSpace(20),
              CGradientMaterialButton(
                  child: Text(
                    "Place Order",
                    style: TypoWhite.white60016,
                  ),
                  onPressed: () {
                    CouponCardController controller =
                        Get.put(CouponCardController());

                    // controller.
                    controller.buyDisscountCard(context,
                        discountId: widget.discountInfoModel.id,
                        price: widget.discountInfoModel.price,
                        deliveryFee: "0");
                  })
            ],
          ),
        ),
      ),
    );
  }

  //amount
  Row buildSingleAmountWidget(String amountName, String price, IconData? icon,
      [TextStyle? style]) {
    return Row(
      children: [
        icon == null
            ? SizedBox()
            : Icon(
                icon,
                color: AppPalette.darkGrey,
                size: 20,
              ),
        Spacing.horizontalSpace(5),
        Text(amountName, style: style ?? TypoDarkGrey.darkGrey40016),
        Spacer(),
        Text("${ConstantText.rupeeSymbol}$price", style: TypoBlack.black60016),
      ],
    );
  }
}
