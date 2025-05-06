import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';

class LuckyChipWidget extends StatelessWidget {
  final String title;
  final bool isActive;

  const LuckyChipWidget({
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
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(title,
            style:
                isActive ? TypoWhite.white50014 : TypoDarkGrey.darkGrey50014),
      ),
      color: WidgetStatePropertyAll(
          isActive ? AppPalette.primaryColor1 : AppPalette.lightGrey2),
    );
  }
}
