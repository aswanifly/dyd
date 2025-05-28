import 'package:dyd/core/data/response/api_response.dart';
import 'package:dyd/model/coupon-model/discount_model.dart';
import 'package:dyd/model/lucky-card-model/lucky_card_model.dart';
import 'package:dyd/model/ticket-model/ticket_details_info_model.dart';
import 'package:dyd/model/ticket-model/ticket_model.dart';
import 'package:logger/logger.dart';

import '../../core/constant/app-url/app_url.dart';
import '../../core/data/remote-data/prefs_contant_utils.dart';
import '../../core/data/remote-data/shared_prefs.dart';
import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';
import '../../model/coupon-model/discount_info_model.dart';

class CouponCardRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<List<DiscountInfoModel>> fGetDiscountCard() async {
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

  static Future<List<DiscountCardModel>> fGetListOfDiscountCards(
      {required String cardStatus}) async {
    try {
      Map<String, dynamic> body = {
        "cardStatus": cardStatus //expired, used
      };
      List<DiscountCardModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.getDiscountcards, token: token, data: body);
      Logger().i(response.response);
      List extData = response.response["data"];
      temp.addAll(extData.map((e) => DiscountCardModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<TicketModel>> fGetLuckyCard(
      {required String filterType}) async {
    try {
      Map<String, dynamic> body = {"filterType": filterType};
      List<TicketModel> temp = [];
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.getLuckyCards, token: token, data: body);
      Logger().i(response.response);
      List extData = response.response["tickets"];
      temp.addAll(extData.map((e) => TicketModel.fromJson(e)).toList());
      return temp;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<TicketDetailsInfoModel> fGetTicketDetailInfo(
      String ticketId) async {
    try {
      Map<String, dynamic> data = {"ticketId": ticketId};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";
      final res = await _apiService.postRequest(
          url: AppUrl.getTicketInfo, data: data, token: token);
      Logger().i(res.response);
      TicketDetailsInfoModel temp =
          TicketDetailsInfoModel.fromJson(res.response["data"]);
      return temp;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> checkActiveDiscountCard() async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.checkActiveDiscountCard, token: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> buyDisscountCard(Map<String, dynamic> body) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.buyDisscountCard, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  static Future<ApiResponse> buyExtraTicket(Map<String, dynamic> body) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.buyExtraTicket, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
