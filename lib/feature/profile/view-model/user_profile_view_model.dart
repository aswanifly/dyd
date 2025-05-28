import 'dart:io';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/helper/error_helper.dart';
import 'package:dyd/core/validator/validators.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/model/user-model/user_profile_model.dart';
import 'package:dyd/repo/auth-repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

class UserProfileViewModel extends GetxController {
  Rx<Status> kProfileLoadingStatus = Rx(Status.initial);
  Rx<Status> kOverlayLoadingStatus = Rx(Status.initial);
  Rx<Status> kOverlayForRegisterLoadingStatus = Rx(Status.initial);

  TextEditingController kUserName = TextEditingController();
  TextEditingController kEmailTxt = TextEditingController();
  TextEditingController kPhone = TextEditingController();

  Rx<UserProfileModel?> kUserProfileDetail = Rx(null);
  RxString kUserImageForRegister = "".obs;

  Future<void> fGetUserProfile(BuildContext context) async {
    try {
      kProfileLoadingStatus(Status.loading);
      final response = await AuthRepo.getCurrentUserProfileRepo();
      UserProfileModel userProfileDetailModel =
          UserProfileModel.fromJson(response.response["data"]);
      kUserProfileDetail.value = userProfileDetailModel;
      kUserName.text = userProfileDetailModel.fullName ?? "";
      kEmailTxt.text = userProfileDetailModel.email ?? "";
      kPhone.text = userProfileDetailModel.phone ?? "";
      kProfileLoadingStatus(Status.success);
    } catch (e) {
      kProfileLoadingStatus(Status.error);
      if (context.mounted) {
        Logger().e(e);
        showCustomSnackBar(context, "Failed to fetch profile: $e");
      }
    }
  }

  Future<void> fUpdateUserProfile(BuildContext context) async {
    if (kEmailTxt.text.trim().isNotEmpty &&
        CustomValidator.emailValidator(value: kEmailTxt.text.trim()) != null) {
      showCustomSnackBar(context, "Please enter a valid email");
      return;
    }
    kOverlayLoadingStatus(Status.loading);
    try {
      Map<String, dynamic> body = {
        "fullName": kUserName.text.trim(),
        "email": kEmailTxt.text.trim(),
        "phone": kPhone.text.trim(),
        "image": kUserProfileDetail.value?.image ?? "",
      };

      Logger().w(body);
      final response = await AuthRepo.editUserProfile(body);
      await fGetUserProfile(context);
      kOverlayLoadingStatus(Status.success);

      Get.back();
      if (context.mounted) {
        showCustomSnackBar(context, response.response["message"]);
      }
    } catch (e) {
      kOverlayLoadingStatus(Status.error);
      if (context.mounted) {
        ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> fPickImage(BuildContext context, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) {
        showCustomSnackBar(
          context,
          "No image selected or permission denied.",
        );
        return;
      }

      if (kUserProfileDetail.value != null) {
        kUserProfileDetail.value = UserProfileModel(
          image: image.path,
          fullName: kUserProfileDetail.value!.fullName,
          email: kUserProfileDetail.value!.email,
          phone: kUserProfileDetail.value!.phone,
        );
      } else {
        kUserProfileDetail.value = UserProfileModel(image: image.path);
      }
      kUserProfileDetail.refresh();
    } catch (e) {
      showCustomSnackBar(context, "Failed to pick image: $e");
    }
  }
}
