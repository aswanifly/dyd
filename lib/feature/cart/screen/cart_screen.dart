import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/core/widget/image-widget/cached_network_image.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/feature/address/view-model/address_view_model.dart';
import 'package:dyd/feature/address/widgets/address_view.dart';
import 'package:dyd/feature/cart/view-model/cart_view_model.dart';
import 'package:dyd/model/address-model/address_model.dart';
import 'package:dyd/model/cart-model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartViewModel cartViewModel = Get.put(CartViewModel());
  AddressViewModel _addressView = Get.put(AddressViewModel());

  @override
  void initState() {
    _addressView.fGetAddedAddress();
    cartViewModel.fGetCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text("Order Summary")),
      body: Obx(() {
        if (cartViewModel.kCartsLoading.value == Status.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (cartViewModel.cartItem.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16),
                Text(
                  "Your cart is empty",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Looks like you haven’t added anything yet.",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order Items", style: TypoBlack.black70018),
                Spacing.verticalSpace(10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartViewModel.cartItem.length,
                  itemBuilder: (BuildContext context, index) {
                    final cart = cartViewModel.cartItem[index];
                    return Card(
                      color: AppPalette.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CNetworkImageRectangularWithTextWidget(
                              name: cart.productName[0],
                              height: 80,
                              width: 80,
                              borderRadius: BorderRadius.circular(8),
                              imageLink: cart.image?.isNotEmpty == true
                                  ? "$IMAGE_URL${cart.image!}"
                                  : "https://cdn.pixabay.com/photo/2022/06/21/21/15/audio-7276511_1280.jpg",
                            ),
                            Spacing.horizontalSpace(10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Spacing.verticalSpace(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cart.productName,
                                          style: TypoBlack.black70016,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartViewModel.removeProductFromCart(
                                              context, cart.product);
                                        },
                                        child: FaIcon(
                                          FontAwesomeIcons.trashCan,
                                          size: 20,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacing.verticalSpace(10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${ConstantText.rupeeSymbol}${cart.price}",
                                          style: TypoBlack.black60016,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (cartViewModel.purchaseQuantity >
                                              1)
                                            cartViewModel.purchaseQuantity--;
                                        },
                                        icon: Icon(
                                          Icons.remove_circle_outline,
                                          color: AppPalette.darkViolet,
                                          size: 30,
                                        ),
                                      ),
                                      Spacing.horizontalSpace(8),
                                      Obx(() => Text(
                                            "${cartViewModel.purchaseQuantity.value}",
                                            style:
                                                TypoDarkViolet.darkViolet60016,
                                          )),
                                      Spacing.horizontalSpace(8),
                                      IconButton(
                                        onPressed: () {
                                          cartViewModel.purchaseQuantity++;
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: AppPalette.darkViolet,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Spacing.verticalSpace(20),
                Text("Delivery Address", style: TypoBlack.black70016),
                _addressView.kAllAddressList.isEmpty
                    ? TextButton(
                        onPressed: () {
                          Get.to(AddressView());
                        },
                        child: Text("Add Address",
                            style: TypoPrimary.primary50014),
                      )
                    : buildSearchedAddressWidget(context),
                Spacing.verticalSpace(15),
                Card(
                  elevation: 0,
                  color: AppPalette.white,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: AppPalette.lightGrey2),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSingleAmountWidget(
                            "Subtotal",
                            "${cartViewModel.subTotal}",
                            Icons.shopping_bag_outlined),
                        buildSingleAmountWidget(
                            "Delivery Fee",
                            "${cartViewModel.deliveryCharges}",
                            Icons.delivery_dining_outlined),
                        buildSingleAmountWidget("Discount",
                            "${cartViewModel.discount}", Icons.percent),
                        Divider(),
                        buildSingleAmountWidget(
                            "Total",
                            "${cartViewModel.finalPrice}",
                            null,
                            TypoBlack.black60016),
                      ],
                    ),
                  ),
                ),
                Spacing.verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time,
                        color: AppPalette.darkGrey, size: 20),
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
                  onPressed: () async {
                    // Check cart items before placing order
                    await cartViewModel.checkCartItem(
                        context, cartViewModel.cartId.value);
                    // Listen to checkCartLoading status
                    if (cartViewModel.kcheckCartLoading.value ==
                        Status.success) {
                      // Only proceed to place order if check is successful
                      await cartViewModel.placeOrder(context);
                    } else {
                      // Optionally show a snackbar if check fails
                      return;
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

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

  Column buildSearchedAddressWidget(BuildContext context) {
    final defaultAddresses = _addressView.kAllAddressList
        .where((item) => item.isDefault == true)
        .toList();

    if (defaultAddresses.isNotEmpty) {
      cartViewModel.addressId.value = defaultAddresses.first.id;
    }

    return Column(
      children: [
        if (defaultAddresses.isNotEmpty)
          ...defaultAddresses.map((addressItem) => Card(
                elevation: 0,
                color: AppPalette.white,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: AppPalette.darkGrey2),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: AppPalette.darkViolet),
                          Text(addressItem.city, style: TypoBlack.black50016),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                Get.to(AddressView());
                              },
                              child: Text("Change",
                                  style: TypoDarkViolet.darkViolet50015)),
                        ],
                      ),
                      Spacing.verticalSpace(5),
                      Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                maxLines: 3,
                                addressItem.area,
                                style: TypoDarkGrey.darkGrey40016),
                            // Spacing.verticalSpace(5),
                            // Text(addressItem.state,
                            //     style: TypoDarkGrey.darkGrey40016),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        if (defaultAddresses.isEmpty)
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                Get.to(AddressView());
              },
              child:
                  Text("No default address found", style: TypoBlack.black50012),
            ),
          ),
      ],
    );
  }
}
