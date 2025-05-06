import 'package:flutter/material.dart';

import '../../config/theme/app_palette.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool centerTitle;
  final bool automaticallyImplyLeading;

  const GradientAppBar({
    super.key,
    this.title,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPalette.primaryColor1, AppPalette.primaryColor2],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: AppBar(
          centerTitle: centerTitle,
          title: title,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
