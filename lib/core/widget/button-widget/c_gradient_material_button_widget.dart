import 'package:flutter/material.dart';

import '../../config/theme/app_palette.dart';

class CGradientMaterialButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final Color? color;
  final ShapeBorder? shape;
  final double? height;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const CGradientMaterialButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.shape,
    this.height,
    this.minWidth,
    this.padding,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppPalette.primaryColor1,
            AppPalette.primaryColor2,
          ],
        ),
      ),
      child: MaterialButton(
        padding: padding,
        elevation: elevation,
        height: height ?? 48,
        minWidth: minWidth ?? double.infinity,
        onPressed: onPressed,
        // color: color ?? AppPalette.primaryColor,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
