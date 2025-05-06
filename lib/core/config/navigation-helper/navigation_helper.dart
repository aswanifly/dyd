import 'package:flutter/material.dart';

extension ExtendedNavigator on BuildContext {
  Future<dynamic> push(Widget page) async {
    Navigator.push(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> pushReplacement(Widget page) async {
    Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> pushAndRemoveUntil(Widget page) async {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (_) => page), (route) => false);
  }

  Future<void> pop([result]) async {
    return Navigator.of(this).pop(result);
  }

  Future<dynamic> pushSlideTransition(Widget page,
      {double first = 0.0, double last = 0.0}) async {
    return Navigator.push(
        this,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = Offset(first, last);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ));
  }

  Future<dynamic> pushFadedTransition(Widget page) async {
    return Navigator.push(
        this,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return page;
          },
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween<double>(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeIn));

            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        ));
  }
}
