import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:dyd/core/data/remote-data/shared_prefs.dart';
import 'package:dyd/core/data/response/api_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';

class AuthRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();
  static Future<ApiResponse> getCurrentUserProfileRepo() async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.getRequest(
          url: AppUrl.getUserProfile, token: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //update user profile
  static Future<ApiResponse> editUserProfile(Map<String, dynamic> body) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.putRequest(
          url: AppUrl.editProfile, token: token, data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> fUserLogin(String email, String password) async {
    try {
      Map<String, dynamic> body = {
        "emailOrPhone": email,
        "password": password,
      };
      final response =
          await _apiService.postRequest(url: AppUrl.login, data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> fForGetPassword(String email) async {
    try {
      Map<String, dynamic> body = {"email": email};
      String token = PreferenceUtils.getString(PrefsConstantUtil.token) ?? "";

      final response = await _apiService.postRequest(
          url: AppUrl.forGetPassword, data: body, token: token);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<ApiResponse> fUserSignUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      Map<String, dynamic> body = {
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "password": password,
        "confirmPassword": password,
        "image": ""
      };
      final response =
          await _apiService.postRequest(url: AppUrl.signUp, data: body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //file upload
  static Future<String> uploadFile(XFile file) async {
    try {
      String token = PreferenceUtils.getString("token") ?? "";
      final response = await _apiService.uploadMediaFile(
          url: AppUrl.uploadImage, token: token, file: file);
      Logger().i(response);
      String imagePath = response["imagePath"];
      return imagePath;
    } catch (e) {
      rethrow;
    }
  }
}
