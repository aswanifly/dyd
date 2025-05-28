import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/data/error/expection_c.dart';
import 'package:dyd/core/data/remote-data/prefs_contant_utils.dart';
import 'package:dyd/core/helper/error_helper.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/feature/auth/screen/login_screen.dart';
import 'package:dyd/feature/landing/screen/image_splash_screen.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';
import 'package:dyd/repo/auth-repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../core/data/remote-data/shared_prefs.dart';
import '../../../core/widget/snackbar/getx_snackbar_widget.dart';

class AuthController extends GetxController {
  Rx<Status> kLoginLoadingStatus = Rx(Status.initial);
  Rx<Status> kSignUpLoadingStatus = Rx(Status.initial);
  Rx<Status> kFOrGetPassWordLoadingStatus = Rx(Status.initial);

  Rx<Status> kFOrGetP = Rx(Status.initial);

  Future<void> fUserLogin(
      BuildContext context, String email, String password) async {
    try {
      kLoginLoadingStatus(Status.loading);
      final response = await AuthRepo.fUserLogin(email, password);

      String token = response.response["user"]["token"];
      PreferenceUtils.setString(PrefsConstantUtil.token, token);

      showCustomSnackBar(context, response.response["message"]);
      kLoginLoadingStatus(Status.success);
    } catch (e) {
      showCustomSnackBar(context, "User not found");
      kLoginLoadingStatus(Status.error);
    }
  }

  Future<void> fForGetPassword(BuildContext context, String email) async {
    try {
      kFOrGetPassWordLoadingStatus(Status.loading);
      final response = await AuthRepo.fForGetPassword(email);
      showCustomSnackBar(context, response.response["message"]);
      showTemporaryPasswordDialog(
          context, response.response["temporaryPassword"]);

      kFOrGetPassWordLoadingStatus(Status.success);
    } catch (e) {
      kFOrGetPassWordLoadingStatus(Status.error);
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
      if (response.response["message"] == "User registered successfully") {
        Get.to(LoginScreen());
      }
    } catch (e) {
      kSignUpLoadingStatus(Status.error);
    }
  }

  void showTemporaryPasswordDialog(
      BuildContext context, String temporaryPassword) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Rounded corners
          ),
          title: Text(
            'Temporary Password Generated',
            style: TypoBlack.black50016,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, // Fit content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'A temporary password has been set for your account. Use it to log in and change your password in your profile settings.',
                  style: TypoDarkGrey.darkGrey50014),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: AppPalette.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppPalette.lightGreen),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                          Text(temporaryPassword, style: TypoBlack.black40016),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy,
                          color: AppPalette.primaryColor2),
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: temporaryPassword));
                        showCustomSnackBar(
                            context, "Password copied to clipboard");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppPalette.darkViolet,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('OK', style: TypoWhite.white40014),
            ),
          ],
        );
      },
    );
  }
}
