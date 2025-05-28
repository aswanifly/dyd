import 'dart:io';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/auth/widget/sign_up_text_field_widget.dart';
import 'package:dyd/feature/profile/view-model/user_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widget/loader/overlay_loader_widget.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final UserProfileViewModel profileViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWidget(
          isLoading:
              profileViewModel.kProfileLoadingStatus.value == Status.loading,
          widget: Scaffold(
            appBar: GradientAppBar(
              centerTitle: true,
              title: const Text("Update Profile"),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildProfilePic(context, profileViewModel),
                    SignUpTextFieldWidget(
                        keyboardType: TextInputType.text,
                        controller: profileViewModel.kUserName,
                        name: "Full Name"),
                    SignUpTextFieldWidget(
                        keyboardType: TextInputType.emailAddress,
                        controller: profileViewModel.kEmailTxt,
                        name: "Email Address"),
                    SignUpTextFieldWidget(
                      controller: profileViewModel.kPhone,
                      name: "Phone Number",
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ),
                    Spacing.verticalSpace(30),
                    CGradientMaterialButton(
                        child: Text("Update", style: TypoWhite.white70016),
                        onPressed: () {
                          profileViewModel.fUpdateUserProfile(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Padding buildProfilePic(
      BuildContext context, UserProfileViewModel profileViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            final userProfile = profileViewModel.kUserProfileDetail.value!;
            if (userProfile.image == null || userProfile.image.isEmpty) {
              return const CircleAvatar(
                radius: 45,
                backgroundColor: AppPalette.lightGrey,
                child: Icon(Icons.person, color: AppPalette.white, size: 50),
              );
            }

            // Check if image is a local file path
            if (File(userProfile.image!).existsSync()) {
              return CircleAvatar(
                radius: 45,
                backgroundImage: FileImage(File(userProfile.image!)),
              );
            }

            return CNetworkImageWithTextWidget(
              imageLink: userProfile.image,
              height: 80,
              width: 80,
              name: userProfile.fullName ?? "User",
            );
          }),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () => profileViewModel.fPickImage(
                          context, ImageSource.camera),
                      child: const Text("Camera"),
                    ),
                    TextButton(
                      onPressed: () => profileViewModel.fPickImage(
                          context, ImageSource.gallery),
                      child: const Text("Gallery"),
                    ),
                  ],
                ),
              );
            },
            child: Text("Change Image", style: TypoBlack.black50016),
          ),
        ],
      ),
    );
  }
}
