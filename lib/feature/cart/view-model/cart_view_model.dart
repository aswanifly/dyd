import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/helper/error_helper.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/feature/order/screen/my_order_screen.dart';
import 'package:dyd/model/cart-model/cart_model.dart';
import 'package:dyd/model/order-model/order_model.dart';
import 'package:dyd/model/order-model/profile_count_model.dart';
import 'package:dyd/model/order-model/track_order_model.dart';

import 'package:dyd/repo/cart-repo/cart_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CartViewModel extends GetxController {
  Rx<Status> kCartsLoading = Rx(Status.initial);
  Rx<Status> kProfileCountsLoading = Rx(Status.initial);
  Rx<Status> kRemovaCartLoading = Rx(Status.initial);
  Rx<Status> kPlaceOrderLoading = Rx(Status.initial);
  Rx<Status> kcheckCartLoading = Rx(Status.initial);

  Rx<Status> kGetOrderLoading = Rx(Status.initial);
  Rx<Status> kTrackOrderLoading = Rx(Status.initial);

  Rx<CartItemModel?> kCartData = Rx(null);
  RxString orderFilters = ''.obs;
  RxString subTotal = ''.obs;
  RxString finalPrice = ''.obs;
  RxString deliveryCharges = ''.obs;
  RxString discount = ''.obs;
  RxString gst = ''.obs;
  RxString cartId = ''.obs;
  RxString orderCount = ''.obs;
  RxString wishListCount = ''.obs;
  RxString discountCount = ''.obs;
  RxString addressId = "".obs;
  final quantities = <String, RxInt>{}.obs;
  RxInt purchaseQuantity = 1.obs;
  Rx<ProfileCountsModel?> profileCountsModel = Rx(null);

  RxList<OrderModel> orderList = <OrderModel>[].obs;

  RxList<CartItem> cartItem = <CartItem>[].obs;
  Rx<TrackOrderModel?> trackOrderModel = Rx(null);

  void initializeQuantities() {
    for (var item in cartItem) {
      quantities[item.id] = RxInt(item.purchaseQuantity);
    }
  }

  void increaseQuantity(String itemId) {
    if (quantities.containsKey(itemId)) {
      quantities[itemId]!.value++;
    }
  }

  void decreaseQuantity(String itemId) {
    if (quantities.containsKey(itemId) && quantities[itemId]!.value > 1) {
      quantities[itemId]!.value--;
    }
  }

  int getQuantity(String itemId) {
    return quantities[itemId]?.value ?? 1;
  }

  Future<void> fGetCartItems() async {
    try {
      kCartsLoading(Status.loading);
      final res = await CartRepo.fGetCartItems();

      if (res != null) {
        kCartData.value = res;
        cartItem.clear();
        cartItem.addAll(kCartData.value?.items ?? []);
      }
      subTotal.value = kCartData.value!.subTotal;
      finalPrice.value = kCartData.value!.finalPrice;
      cartId.value = kCartData.value!.cartId;
      deliveryCharges.value = kCartData.value!.deliveryCharges;
      discount.value = kCartData.value!.discount;
      int totalQuantity =
          cartItem.fold(0, (sum, item) => sum + item.purchaseQuantity);
      purchaseQuantity.value = totalQuantity;

      kCartsLoading(Status.success);
    } catch (e) {
      print(e);

      kCartsLoading(Status.error);
    }
  }

  Future<void> fetchOrderTracking(BuildContext context, String orderId) async {
    try {
      kTrackOrderLoading(Status.loading);
      final res = await CartRepo.fTrackOrder(orderId: orderId);
      trackOrderModel.value = res;
    } catch (e) {
      kTrackOrderLoading(Status.error);
    }
  }

  Future<void> fGetProfilesCounts() async {
    try {
      kProfileCountsLoading(Status.loading);

      final response = await CartRepo.getProfileCounts();
      ProfileCountsModel profileCountsModel =
          ProfileCountsModel.fromJson(response.response["data"]);
      orderCount.value = profileCountsModel.ordersCount;
      discountCount.value = profileCountsModel.discountCardCount;
      wishListCount.value = profileCountsModel.wishlistCount;
      kProfileCountsLoading(Status.success);
    } catch (e) {
      print(e);

      kProfileCountsLoading(Status.error);
    }
  }

  Future<void> placeOrder(
    BuildContext context,
  ) async {
    try {
      final List<Map<String, dynamic>> products = cartItem.map((cart) {
        return {
          "price": double.tryParse(cart.price) ?? 0.0,
          "product": cart.product,
          "productName": cart.productName,
          "purchaseQuantity": purchaseQuantity.value,
          "discount": double.tryParse(cart.discount) ?? 0.0,
          "gst": double.tryParse(cart.gst) ?? 0.0,
          "subTotal": double.tryParse(cart.subTotal) ?? 0.0,
          "finalPrice": double.tryParse(cart.finalPrice) ?? 0.0,
        };
      }).toList();
      Map<String, dynamic> data = {
        "products": products,
        "totalItemsPrice": double.tryParse(finalPrice.value) ?? 0.0,
        "totalDiscount": double.tryParse(discount.value) ?? 0.0,
        "couponAmount": 0,
        "deliveryFee": double.tryParse(deliveryCharges.value) ?? 0.0,
        "totalAmount": double.tryParse(finalPrice.value) ?? 0.0,
        "address": addressId.value,
        "orderPaymentDetails": {
          "signature": null,
          "orderId": null,
          "paymentId": null
        }
      };
      kPlaceOrderLoading(Status.loading);
      final response = await CartRepo.placeOrder(data);
      Logger().i(response.response);

      fGetCartItems();
      if (response.response["message"] == "Order placed successfully.") {
        Get.to(MyOrderScreen());
      }
      kPlaceOrderLoading(Status.success);
      ();
      if (context.mounted) {
        showCustomSnackBar(context, response.response["message"]);
      }
    } catch (e) {
      kPlaceOrderLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> removeProductFromCart(
      BuildContext context, String productId) async {
    try {
      kRemovaCartLoading(Status.loading);
      final response =
          await CartRepo.removeProductFromCart(productId: productId);
      Logger().i(response.response);

      fGetCartItems();
      kRemovaCartLoading(Status.success);
      ();
      if (context.mounted) {
        showCustomSnackBar(context, response.response["message"]);
      }
    } catch (e) {
      kRemovaCartLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> checkCartItem(BuildContext context, String cartId) async {
    try {
      kcheckCartLoading(Status.loading);
      final response = await CartRepo.checkCart(cartId: cartId);
      Logger().i(response.response);

      fGetCartItems();
      kcheckCartLoading(Status.success);
      ();
      // if (context.mounted) {
      //   showCustomSnackBar(context, response.response["message"]);
      // }
    } catch (e) {
      kcheckCartLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> fGetOrderList(
    BuildContext context,
  ) async {
    try {
      kGetOrderLoading(Status.loading);
      final response =
          await CartRepo.fGetListOrder(filterType: orderFilters.value);

      orderList.clear();
      orderList.addAll(response);

      kGetOrderLoading(Status.success);
    } catch (e) {
      kGetOrderLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }
}
