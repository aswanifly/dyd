import 'package:dyd/core/typo/black_typo.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';

class CategoryChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final void Function()? onTap;

  const CategoryChipWidget({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Chip(
          label: Text(label,
              style: TextStyle(color: selected ? Colors.white : Colors.black)),
          backgroundColor:
              selected ? AppPalette.primaryColor1 : AppPalette.lightGrey2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color:
                  selected ? AppPalette.primaryColor1 : AppPalette.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
