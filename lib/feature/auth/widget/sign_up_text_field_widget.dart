import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/widget/text-field-widget/c_text_field_widget.dart';
import 'package:flutter/material.dart';

class SignUpTextFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;

  const SignUpTextFieldWidget({
    super.key,
    required this.name,
    required this.controller,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TypoDarkGrey.darkGrey50014,
        ),
        Spacing.verticalSpace(5),
        CTextField(
          maxLength: maxLength,
          keyboardType: keyboardType,
          controller: controller,
          hintText: name,
        ),
        Spacing.verticalSpace(10),
      ],
    );
  }
}
