import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/validator/validators.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/core/widget/text-field-widget/c_text_field_widget.dart';
import 'package:dyd/feature/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForGetPassword extends StatelessWidget {
  const ForGetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailTxt = TextEditingController();
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text("Fotget Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailTxt,
              prefixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.mail,
                    color: AppPalette.lightGrey,
                  )),
              hintText: "Email",
            ),
            Spacing.verticalSpace(25),
            CGradientMaterialButton(
              onPressed: () {
                if (emailTxt.text.isEmpty) {
                  showCustomSnackBar(context, "Please enter email");
                  return;
                } else if (emailTxt.text.trim().isNotEmpty &&
                    CustomValidator.emailValidator(
                            value: emailTxt.text.trim()) !=
                        null) {
                  showCustomSnackBar(context, "Please enter valid email");
                  return;
                }
                AuthController authController = Get.put(AuthController());
                authController
                    .fForGetPassword(context, emailTxt.text.trim())
                    .then((value) {});
              },
              child: Text("Fotget Password", style: TypoWhite.white70016),
            ),
          ],
        ),
      ),
    );
  }
}
