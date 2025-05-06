import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';
import '../../../core/typo/black_typo.dart';

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final void Function()? onTap;

  const CategoryChipWidget({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(label, style: TypoBlack.black40014),
          color: WidgetStatePropertyAll(AppPalette.lightGrey2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppPalette.transparent)),
        ),
      ),
    );
  }
}
