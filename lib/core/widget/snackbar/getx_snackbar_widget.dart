import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarGetXUtils {
  static void show({
    required String message,
    IconData? icon,
    Color backgroundColor = AppPalette.darkViolet,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TypoWhite.white60016,
      ),
      titleText: null,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      backgroundColor: backgroundColor,
      snackPosition: position,
      duration: duration,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      borderRadius: 12,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOut,
    );
  }
}

void showCustomSnackBar(BuildContext? context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent, // Make background transparent
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    content: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPalette.primaryColor1,
            AppPalette.primaryColor2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message,
        style: TypoWhite.white50016,
      ),
    ),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}
