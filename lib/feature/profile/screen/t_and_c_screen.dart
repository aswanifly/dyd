import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:flutter/material.dart';

class TAndCScreen extends StatelessWidget {
  const TAndCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("Terms & Condition"),
      ),
    );
  }
}
