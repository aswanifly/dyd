import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:flutter/material.dart';

import 'app_palette.dart';

class AppTheme {
  static _border([Color color = AppPalette.lightGrey, double width = 1.0]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );

  _searchBorder([Color color = AppPalette.lightGrey, double width = 1.0]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );

  static final lightThemeMode = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppPalette.whiteShade,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: Colors.white),
        color: AppPalette.primaryColor1,
        titleTextStyle: TypoWhite.white70018,
      ),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(18),
          labelStyle: LightGreyTypo.lightGrey40016,
          hintStyle: LightGreyTypo.lightGrey40016,
          border: _border(),
          enabledBorder: _border(AppPalette.darkGrey),
          focusedBorder: _border(AppPalette.primaryColor1, 2),
          errorBorder: _border(AppPalette.red)),
      dialogBackgroundColor: AppPalette.white);
}
