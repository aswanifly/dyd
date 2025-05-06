import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:dyd/repo/auth-repo/auth_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../core/data/remote-data/shared_prefs.dart';
import '../../../core/widget/snackbar/getx_snackbar_widget.dart';

class AuthController extends GetxController {
  Rx<Status> kLoginLoadingStatus = Rx(Status.initial);
  Rx<Status> kSignUpLoadingStatus = Rx(Status.initial);

  Future<void> fUserLogin(String email, String password) async {
    try {
      kLoginLoadingStatus(Status.loading);
      final response = await AuthRepo.fUserLogin(email, password);
      String token = response.response["user"]["token"];
      PreferenceUtils.setString(PrefsConstantUtil.token, token);
      kLoginLoadingStatus(Status.success);
    } catch (e) {
      kLoginLoadingStatus(Status.error);
    }
  }

  Future<void> fUserSignUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      kSignUpLoadingStatus(Status.loading);
      final response = await AuthRepo.fUserSignUp(
          email: email, password: password, fullName: fullName, phone: phone);
      SnackBarGetXUtils.show(message: response.response["message"]);
      kSignUpLoadingStatus(Status.success);
    } catch (e) {
      kSignUpLoadingStatus(Status.error);
    }
  }
}
