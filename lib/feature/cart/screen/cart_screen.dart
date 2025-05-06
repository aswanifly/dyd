import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/cart/widget/cart_item_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              CartItemCardWidgetWithCountButton(),
              CartItemCardWidgetWithOutCountButton(),
              Spacing.verticalSpace(20),
              Text("Delivery Address", style: TypoBlack.black70016),
              buildAddressCardWidget(),
              Spacing.verticalSpace(15),
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
                          "Subtotal", "100", Icons.shopping_bag_outlined),
                      buildSingleAmountWidget(
                          "Delivery Fee", "10", Icons.delivery_dining_outlined),
                      buildSingleAmountWidget("Discount", "-20", Icons.percent),
                      Divider(),
                      buildSingleAmountWidget(
                          "Total", "200", null, TypoBlack.black60016),
                    ],
                  ),
                ),
              ),
              Spacing.verticalSpace(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.access_time, color: AppPalette.darkGrey, size: 20),
                  Spacing.horizontalSpace(8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Estimated Delivery Time",
                          style: TypoBlack.black50016),
                      Spacing.verticalSpace(5),
                      Text("Tomorrow 2-4 PM",
                          style: TypoDarkGrey.darkGrey50014),
                    ],
                  ),
                ],
              ),
              Spacing.verticalSpace(20),
              CGradientMaterialButton(
                  child: Text(
                    "Place Order",
                    style: TypoWhite.white60016,
                  ),
                  onPressed: () {})
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

  Card buildAddressCardWidget() {
    return Card(
      elevation: 0,
      color: AppPalette.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppPalette.darkGrey2),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on_outlined, color: AppPalette.darkViolet),
                Text("Home", style: TypoBlack.black50016),
                Spacer(),
                Text("Change", style: TypoDarkViolet.darkViolet50015),
              ],
            ),
            Spacing.verticalSpace(5),
            Padding(
              padding: const EdgeInsets.only(left: 23),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("123 street", style: TypoDarkGrey.darkGrey40016),
                  Spacing.verticalSpace(5),
                  Text("Delhi", style: TypoDarkGrey.darkGrey40016),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
