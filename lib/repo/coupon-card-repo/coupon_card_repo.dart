import 'package:dyd/core/data/response/api_response.dart';
import 'package:logger/logger.dart';

import '../../core/constant/app-url/app_url.dart';
import '../../core/data/remote-data/prefs_contant_utils.dart';
import '../../core/data/remote-data/shared_prefs.dart';
import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';
import '../../model/coupon-model/discount_info_model.dart';

class CouponCardRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<List<DiscountInfoModel>> fGetDiscountDetail() async {
    try {
      List<DiscountInfoModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.getDiscountCardInfo, token: token);
      Logger().i(response.response);
      List extData = response.response["discountCards"];
      temp.addAll(extData.map((e) => DiscountInfoModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
