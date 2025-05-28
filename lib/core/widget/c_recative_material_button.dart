import 'package:dyd/core/typo/white_typo.dart';
import 'package:flutter/material.dart';

import '../../../core/config/theme/app_palette.dart';

class CReactiveMaterialButton extends StatelessWidget {
  final String buttonName;
  final TextStyle? textStyle;
  final void Function() onPressed;
  final Color? color;
  final ShapeBorder? shape;
  final double? height;
  final double? minWidth;
  final EdgeInsetsGeometry? padding;
  final bool? isLoading;

  const CReactiveMaterialButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.isLoading,
    this.color,
    this.shape,
    this.height,
    this.minWidth,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading == null) {
      return _initial();
    } else {
      return isLoading! ? _loading() : _initial();
    }
  }

  Widget _initial() {
    return MaterialButton(
      padding: padding,
      height: height ?? 56,
      minWidth: minWidth ?? double.infinity,
      onPressed: onPressed,
      color: color ?? AppPalette.primaryColor1,
      shape: shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        buttonName,
        style: textStyle ?? TypoWhite.white40014,
      ),
    );
  }

  Widget _loading() {
    return MaterialButton(
        padding: padding,
        height: height ?? 56,
        minWidth: minWidth ?? double.infinity,
        onPressed: () {},
        color: color ?? AppPalette.primaryColor1,
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(color: Colors.white)));
  }
}
