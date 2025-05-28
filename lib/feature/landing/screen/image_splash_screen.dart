import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';

class NavigationScreenWithPopup extends StatefulWidget {
  @override
  _NavigationScreenWithPopupState createState() =>
      _NavigationScreenWithPopupState();
}

class _NavigationScreenWithPopupState extends State<NavigationScreenWithPopup> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                'assets/vedios/splash_screen.gif',
                width: 110,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );

        // Auto-close the dialog after 6 seconds
        Future.delayed(Duration(seconds: 6), () {
          if (mounted && Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationScreen(); // Your existing screen content
  }
}
