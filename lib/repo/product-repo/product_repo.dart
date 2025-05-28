import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/response/api_response.dart';
import 'package:dyd/model/hotdeals-model/hot_deals_model.dart';
import 'package:dyd/model/product-model/all_product_model.dart';
import 'package:dyd/model/product-model/related_product_model.dart';
import 'package:dyd/model/wish-list-model/wish_list_model.dart';
import 'package:logger/logger.dart';

import '../../core/data/remote-data/prefs_contant_utils.dart';
import '../../core/data/remote-data/shared_prefs.dart';
import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';
import '../../model/product-model/product_detail_model.dart';
import '../../model/product-model/product_model.dart';

class ProductRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<List<ProductModel>> fGetProductByCategory(
      String categoryId) async {
    try {
      List<ProductModel> tempList = [];
      Map<String, dynamic> data = {
        "categoryId": categoryId,
        "page": 1,
        "limit": 50
      };
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.getProductByCategory, data: data, token: token);
      List extData = res.response["data"];
      tempList.addAll(extData.map((e) => ProductModel.fromJson(e)).toList());
      return tempList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<RelatedProductModel>> fGetRelatedProducts(
      String productId) async {
    try {
      List<RelatedProductModel> tempList = [];
      Map<String, dynamic> data = {
        "productId": productId,
      };
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.getRelatedProducts, data: data, token: token);
      List extData = res.response["data"];
      tempList
          .addAll(extData.map((e) => RelatedProductModel.fromJson(e)).toList());
      return tempList;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<AllProductModel>> fGetAllProducts(
      Map<String, dynamic> data) async {
    try {
      List<AllProductModel> tempList = [];

      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.getAllProducts, data: data, token: token);
      List extData = res.response["data"];
      tempList.addAll(extData.map((e) => AllProductModel.fromJson(e)).toList());
      return tempList;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  static Future<ProductDetailModel> fGetProductDetail(String productId) async {
    try {
      Map<String, dynamic> data = {"productId": productId};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.getProductInfo, data: data, token: token);
      Logger().i(res.response);
      ProductDetailModel temp =
          ProductDetailModel.fromJson(res.response["data"]);
      return temp;
    } catch (e) {
      rethrow;
    }
  }

//add whishlist
  static Future<ApiResponse> addToWhishList(String productId) async {
    try {
      Map<String, dynamic> body = {"productId": productId};
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.addToWhishList, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  //get wishList
  static Future<List<WishListProductModel>> fGetWishList(
    Map<String, dynamic> data,
  ) async {
    try {
      List<WishListProductModel> tempList = [];

      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          data: data, url: AppUrl.getUserWhitelist, token: token);
      List extData = res.response["data"];
      tempList.addAll(
          extData.map((e) => WishListProductModel.fromJson(e)).toList());
      return tempList;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  //remove from wishlist
  static Future<ApiResponse> removeFromWhishList(String productId) async {
    try {
      Map<String, dynamic> body = {"productId": productId};
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.deleteRequest(
          url: AppUrl.removeFromWishlist, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  static Future<List<HotDealsModel>> fGetHotDeals() async {
    try {
      List<HotDealsModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response =
          await _apiService.getRequest(url: AppUrl.getHotDeals, token: token);
      Logger().i(response.response);
      List extData = response.response["data"];
      temp.addAll(extData.map((e) => HotDealsModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      rethrow;
    }
  }
}
