import 'package:dyd/core/constant/app-url/app_url.dart';
import 'package:dyd/core/data/response/api_response.dart';

import '../../core/data/response/api_call_type_response.dart';
import '../../dependency_injection.dart';

class AuthRepo {
  static final ApiCallType _apiService = getIt<ApiCallType>();

  static Future<ApiResponse> fUserLogin(String email, String password) async {
    try {
      Map<String, dynamic> body = {"emailOrPhone": email, "password": password};
      final response =
          await _apiService.postRequest(url: AppUrl.login, data: body);
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
}
