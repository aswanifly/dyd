import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OverlayLoaderWidget extends StatelessWidget {
  final bool isLoading;
  final Widget widget;

  const OverlayLoaderWidget( 
      {super.key, this.isLoading = false, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [widget, isLoading ? buildLoaderWidget() : SizedBox()]);
  }

  Widget buildLoaderWidget() {
    return Material(
      color: Colors.black12,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Container(
            height: 110,
            width: 140,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10)
            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SpinKitFadingCircle(color: AppPalette.mobileColor1),
                Spacing.verticalSpace(5),
                Text("Loading...", style: TypoWhite.white60016)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
