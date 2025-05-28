import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:dyd/core/data/remote-data/shared_prefs.dart';
import 'package:dyd/core/data/response/api_call_type_response.dart';
import 'package:dyd/core/data/response/api_response.dart';
import 'package:dyd/dependency_injection.dart';
import 'package:dyd/model/cart-model/cart_model.dart';
import 'package:dyd/model/order-model/order_model.dart';
import 'package:dyd/model/order-model/profile_count_model.dart';
import 'package:dyd/model/order-model/track_order_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:logger/web.dart';

class CartRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<CartItemModel> fGetCartItems() async {
    try {
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res =
          await _apiService.getRequest(url: AppUrl.getCartItems, token: token);
      Logger().i(res.response);
      CartItemModel temp =
          CartItemModel.fromJson(res.response["data"] ?? res.response);
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<TrackOrderModel> fTrackOrder({required String orderId}) async {
    try {
      Map<String, dynamic> data = {"orderId": orderId};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.trackOrder, token: token, data: data);
      Logger().i(res.response);
      TrackOrderModel temp =
          TrackOrderModel.fromJson(res.response["data"] ?? res.response);
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> getProfileCounts() async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.getProfileCounts, token: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> fAddProductToCart(
      Map<String, dynamic> data) async {
    try {
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.addToCart, data: data, token: token);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> placeOrder(Map<String, dynamic> data) async {
    try {
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.placeOrder, data: data, token: token);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> removeProductFromCart(
      {required String productId}) async {
    try {
      Map<String, dynamic> data = {"productId": productId};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.removeCart, data: data, token: token);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> checkCart({required String cartId}) async {
    try {
      Map<String, dynamic> data = {"cartId": cartId};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.checkCartItem, data: data, token: token);
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<OrderModel>> fGetListOrder(
      {required String filterType}) async {
    try {
      Map<String, dynamic> body = {
        "month": "",
        "year": "",
        "orderStatus": filterType //    "InTransit",  "Cancelled
      };
      List<OrderModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.getListOrder, token: token, data: body);
      Logger().i(response.response);
      List extData = response.response["data"];
      temp.addAll(extData.map((e) => OrderModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
