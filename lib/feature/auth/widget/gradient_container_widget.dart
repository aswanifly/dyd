import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';

class GradientContainerWidget extends StatelessWidget {
  final Widget widget;

  const GradientContainerWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppPalette.primaryColor2,
            AppPalette.primaryColor1,
          ],
        ),
      ),
      child: widget,
    );
  }
}
