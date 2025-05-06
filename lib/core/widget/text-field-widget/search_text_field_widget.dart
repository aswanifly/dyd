import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_palette.dart';

class CSearchBar extends StatelessWidget {
  const CSearchBar(
      {super.key,
      this.borderRadius,
      this.borderColor,
      this.borderWidth,
      required this.onChanged,
      this.controller,
      this.suffixIcon,
      this.enabled,
      this.onTap,
      this.hintText = "Search Product"});

  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final TextEditingController? controller;
  final void Function(String v) onChanged;
  final Widget? suffixIcon;
  final bool? enabled;
  final void Function()? onTap;
  final String hintText;

  OutlineInputBorder _border({Color? color, double? radius, double? width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? radius!),
      borderSide: BorderSide(
        color: Colors.transparent,
        width: borderWidth ?? width!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: controller,
          enabled: enabled,
          onTap: onTap,
          onChanged: (value) => onChanged(value),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppPalette.lightGrey2,
            border:
                _border(color: AppPalette.lightGrey, radius: 50, width: 1.0),
            enabledBorder:
                _border(color: AppPalette.lightGrey, radius: 50, width: 1.0),
            focusedBorder: _border(
                color: AppPalette.primaryColor1, radius: 50, width: 1.0),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            prefixIcon: const Icon(
              Icons.search,
              color: AppPalette.lightGrey,
            ),
            label: Text(
              hintText,
              style: LightGreyTypo.lightGrey40014,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
