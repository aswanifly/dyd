import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/typo/yellow_typo.dart';
import 'package:dyd/core/widget/loader/overlay_loader_widget.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/core/widget/text-field-widget/c_text_field_widget.dart';
import 'package:dyd/feature/auth/controller/auth_controller.dart';
import 'package:dyd/feature/auth/screen/for_get_password.dart';
import 'package:dyd/feature/auth/screen/signup_screen.dart';
import 'package:dyd/feature/auth/widget/gradient_container_widget.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';
import 'package:dyd/splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../core/widget/button-widget/c_gradient_material_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneNumberTxt = TextEditingController();
  final emailTxt = TextEditingController();
  final passwordTxt = TextEditingController();
  bool _isPhoneSelected = true;

  // Function to dismiss the keyboard
  void _dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());

    return Obx(() => OverlayLoaderWidget(
          isLoading: authController.kLoginLoadingStatus.value == Status.loading,
          widget: Scaffold(
            body: GradientContainerWidget(
                widget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    context.verticalSpacing(0.08),
                    Image.asset(ImageHelper.appLogoPNG),
                    Spacing.verticalSpace(10),
                    Text(
                      "Win Big Today!",
                      style: TypoWhite.white70024,
                    ),
                    Spacing.verticalSpace(10),
                    Text("Your Luck is Just a Login Away",
                        style: TypoYellow.yellow50014),
                    Spacing.verticalSpace(10),
                    Card(
                      elevation: 0,
                      color: AppPalette.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _dismissKeyboard(); // Dismiss keyboard
                                    setState(() {
                                      _isPhoneSelected = true;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: _isPhoneSelected
                                              ? Colors.deepPurple
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Phone Number',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          color: _isPhoneSelected
                                              ? Color(0xFF4B1BBC)
                                              : Color(0xFF4B5563),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    _dismissKeyboard(); // Dismiss keyboard
                                    setState(() {
                                      _isPhoneSelected = false;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: !_isPhoneSelected
                                              ? Colors.deepPurple
                                              : Colors.transparent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          color: !_isPhoneSelected
                                              ? Color(0xFF4B1BBC)
                                              : Color(0xFF4B5563),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacing.verticalSpace(5),
                            _isPhoneSelected
                                ? CTextField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    controller: phoneNumberTxt,
                                    prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.phone_android,
                                          color: AppPalette.lightGrey,
                                        )),
                                    hintText: "Phone",
                                  )
                                : CTextField(
                                    controller: emailTxt,
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.mail,
                                          color: AppPalette.lightGrey,
                                        )),
                                    hintText: "Email",
                                  ),
                            Spacing.verticalSpace(15),
                            Text(
                              "Password",
                              style: TypoDarkGrey.darkGrey50014,
                            ),
                            Spacing.verticalSpace(5),
                            CPTextField(
                              keyboardType: TextInputType.text,
                              controller: passwordTxt,
                              hintText: "Password",
                              isObscureText: true,
                              prefixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.lock,
                                    color: AppPalette.lightGrey,
                                  )),
                            ),
                            Spacing.verticalSpace(25),
                            CGradientMaterialButton(
                              onPressed: () {
                                authController
                                    .fUserLogin(
                                        context,
                                        _isPhoneSelected
                                            ? phoneNumberTxt.text.trim()
                                            : emailTxt.text.trim(),
                                        passwordTxt.text.trim())
                                    .then((value) {
                                  if (authController
                                          .kLoginLoadingStatus.value ==
                                      Status.success) {
                                    Get.off(NavigationScreen());
                                  }
                                });
                              },
                              child: Text("LOGIN", style: TypoWhite.white70016),
                            ),
                            Spacing.verticalSpace(15),
                            Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(ForGetPassword());
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TypoPrimary.primary50014,
                                    ),
                                  ),
                                  Spacing.verticalSpace(15),
                                  RichText(
                                    text: TextSpan(
                                      text: "Don't have an account? ",
                                      style: TypoDarkGrey.darkGrey50014,
                                      children: [
                                        TextSpan(
                                            text: 'Sign Up',
                                            style: TypoPrimary.primary70016,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.pushFadedTransition(
                                                    SignupScreen());
                                              }),
                                      ],
                                    ),
                                  ),
                                  Spacing.verticalSpace(15),
                                  Text(
                                    "By continuing you agree to our",
                                    style: TypoDarkGrey.darkGrey50014,
                                  ),
                                  Text(
                                    "Terms of Service and Privacy Policy",
                                    style: TypoDarkGrey.darkGrey50012UnderLine,
                                  ),
                                  Spacing.verticalSpace(15),
                                  // buildSocialMediaLinkWidget()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ));
  }

  Row buildSocialMediaLinkWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Card(
            elevation: 0,
            color: AppPalette.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AppPalette.lightGrey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FaIcon(
                  FontAwesomeIcons.youtube,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 0,
            color: AppPalette.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AppPalette.lightGrey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FaIcon(
                  FontAwesomeIcons.instagram,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 0,
            color: AppPalette.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: AppPalette.lightGrey)),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FaIcon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
