import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/feature/auth/controller/auth_controller.dart';
import 'package:dyd/feature/auth/widget/sign_up_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/loader/overlay_loader_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final fullNameTxt = TextEditingController();
  final emailTxt = TextEditingController();
  final phoneTxt = TextEditingController();
  final passwordTxt = TextEditingController();
  final confirmPasswordTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return OverlayLoaderWidget(
      isLoading: authController.kSignUpLoadingStatus.value == Status.loading,
      widget: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.verticalSpacing(0.08),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(ImageHelper.signUpPNG)),
                Spacing.verticalSpace(15),
                Text(
                  "Create Account",
                  style: TypoPrimary.primary70028,
                ),
                Spacing.verticalSpace(15),
                SignUpTextFieldWidget(
                    controller: fullNameTxt, name: "Full Name"),
                SignUpTextFieldWidget(
                    controller: emailTxt, name: "Email Address"),
                SignUpTextFieldWidget(
                    controller: passwordTxt, name: "Password"),
                SignUpTextFieldWidget(
                    controller: confirmPasswordTxt, name: "Confirm Password"),
                Spacing.verticalSpace(30),
                CGradientMaterialButton(
                    child: Text("Sign Up", style: TypoWhite.white70016),
                    onPressed: () {
                      authController
                          .fUserSignUp(
                              email: emailTxt.text.trim(),
                              password: passwordTxt.text.trim(),
                              fullName: fullNameTxt.text.trim(),
                              phone: phoneTxt.text.trim())
                          .then((value) {
                        if (authController.kSignUpLoadingStatus.value ==
                            Status.success) {
                          if (context.mounted) {
                            context.pop();
                          }
                        }
                      });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
