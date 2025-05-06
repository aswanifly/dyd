import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:flutter/material.dart';

import '../../../core/typo/white_typo.dart';

class OrderChipWidget extends StatelessWidget {
  final String title;
  final bool isActive;

  const OrderChipWidget({
    super.key,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(color: AppPalette.transparent)),
      label: Text(title,
          style:
              isActive ? TypoWhite.white50014 : TypoDarkGrey.darkGrey50014),
      color: WidgetStatePropertyAll(
          isActive ? AppPalette.primaryColor1 : AppPalette.lightGrey2),
    );
  }
}
