import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/response/api_response.dart';
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
        "limit": 20
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
}
