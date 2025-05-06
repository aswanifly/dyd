import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class CMaterialButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final Color? color;
  final ShapeBorder? shape;
  final double? height;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final double? elevation;

  const CMaterialButton({
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
    return MaterialButton(
      padding: padding,
      elevation: elevation,
      height: height ?? 48,
      minWidth: minWidth ?? double.infinity,
      onPressed: onPressed,
      color: color,
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
