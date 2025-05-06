import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/primary_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/typo/yellow_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:flutter/material.dart';

import '../widget/order_card_widget.dart';
import '../widget/order_chip_widget.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        title: Text("My Orders"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          buildOrderStatusWidget(),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (_, index) => OrderCardWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildOrderStatusWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OrderChipWidget(
              title: "All",
              isActive: true,
            ),
            OrderChipWidget(
              title: "In Transit",
              isActive: true,
            ),
            OrderChipWidget(
              title: "Active",
              isActive: false,
            ),
            OrderChipWidget(
              title: "Complete",
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
