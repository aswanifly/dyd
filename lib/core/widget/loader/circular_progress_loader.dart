import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/theme/app_palette.dart';

class CLoadingCircularLoader extends StatelessWidget {
  const CLoadingCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(color: AppPalette.mobileColor1),
    );
  }
}
