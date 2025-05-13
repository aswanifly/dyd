import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:dyd/core/data/remote-data/shared_prefs.dart';
import 'package:dyd/core/data/response/api_response.dart';
import 'package:dyd/model/home-model/available_draws_model.dart';
import 'package:dyd/model/home-model/recent_winner_model.dart';

import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';
import '../../model/home-model/home_shopping_category_model.dart';

class HomeRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<List<HomeShoppingCategoryModel>>
      fGetHomeListOfCategories() async {
    try {
      List<HomeShoppingCategoryModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.getListOfCategories, token: token);
      List extData = response.response["data"];
      temp.addAll(
          extData.map((e) => HomeShoppingCategoryModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<RecentWinnerModel>> fGetRecentWinnerList() async {
    try {
      List<RecentWinnerModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response =
          await _apiService.getRequest(url: AppUrl.recentWinners, token: token);
      List extData = response.response["winners"];
      temp.addAll(extData.map((e) => RecentWinnerModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<AvailableDrawsModel>> fGetAvailableDraws() async {
    try {
      List<AvailableDrawsModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.availableDraws, token: token);
      List extData = response.response["availableDraws"];
      temp.addAll(extData.map((e) => AvailableDrawsModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      rethrow;
    }
  }
}
