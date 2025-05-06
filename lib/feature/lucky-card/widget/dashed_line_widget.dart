import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';

class DashedLineWidget extends StatelessWidget {
  final Color? color;
  final int noOfLines;

  const DashedLineWidget({super.key, this.color, this.noOfLines = 28});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(noOfLines, (index) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: 2,
              width: 5,
              color: color ?? AppPalette.lightGrey2,
            ),
          ),
        );
      }),
    );
  }
}
