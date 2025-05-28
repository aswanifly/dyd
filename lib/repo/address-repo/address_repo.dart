import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/remote-data/shared_prefs.dart';
import 'package:dyd/core/data/response/api_call_type_response.dart';
import 'package:dyd/core/data/response/api_response.dart';
import 'package:dyd/model/address-model/address_model.dart';
import 'package:logger/logger.dart';

import '../../dependency_injection.dart';

class AddressRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<ApiResponse> fAddNewAddress(Map<String, dynamic> body) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.addAddress, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  static Future<ApiResponse> fEditAddedAddress(
      Map<String, dynamic> body) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.putRequest(
          url: AppUrl.updateAddress, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  static Future<List<AddressDetailModel>> fGetAddedAddress() async {
    try {
      List<AddressDetailModel> tempSavedAddressList = [];
      List<AddressDetailModel> searchedAddressList = [];
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.getListOfAddresses, token: token);
      List extData = response.response["data"];
      Logger().i(extData);
      // List<AddressDetailModel> convertedData =
      searchedAddressList
          .addAll(extData.map((e) => AddressDetailModel.fromJson(e)).toList());

      // for (int i = 0; i < convertedData.length; i++) {
      //   if (convertedData[i].name.isEmpty) {
      //     searchedAddressList.add(convertedData[i]);
      //   } else {
      //     tempSavedAddressList.add(convertedData[i]);
      //   }
      // }
      return searchedAddressList;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  //set Default address
  static Future<ApiResponse> fSetDefaultAddress(String addressId) async {
    try {
      Map<String, dynamic> body = {"addressId": addressId};
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.setAddress, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  //delete
  static Future<ApiResponse> fDeleteAddress(String addressId) async {
    try {
      Map<String, dynamic> body = {"addressId": addressId};
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.postRequest(
          url: AppUrl.deleteAddress, token: token, data: body);
      return response;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }
}
