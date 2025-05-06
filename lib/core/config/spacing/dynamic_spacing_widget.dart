//dynamic spacing
import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  //vertical-spacing
  SizedBox verticalSpacing(double factor) =>
      SizedBox(height: MediaQuery.of(this).size.height * factor);

  //horizontal-spacing
  SizedBox horizontalSpacing(double factor) =>
      SizedBox(width: MediaQuery.of(this).size.height * factor);

  //height
  double dynamicHeight(double factor) =>
      MediaQuery.of(this).size.height * factor;

  //width
  double dynamicWidth(double factor) => MediaQuery.of(this).size.width * factor;
}
