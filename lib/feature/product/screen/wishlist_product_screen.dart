import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/feature/product/widget/wishlist_product_card_widget.dart';
import 'package:flutter/material.dart';

class WishlistProductScreen extends StatelessWidget {
  const WishlistProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> productList = [
      "https://cdn.pixabay.com/photo/2024/10/29/07/21/headphones-9158344_1280.jpg",
      "https://cdn.pixabay.com/photo/2014/07/31/23/42/handbag-407198_1280.jpg",
      "https://cdn.pixabay.com/photo/2020/10/21/18/07/laptop-5673901_1280.jpg",
      "https://cdn.pixabay.com/photo/2015/06/25/17/22/smart-watch-821559_1280.jpg",
      "https://cdn.pixabay.com/photo/2023/05/18/11/32/motorcycle-8002032_1280.jpg",
      "https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070_1280.jpg",
    ];
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        title: Text("Wishlist"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     buildFilterWidget("Sort", AppPalette.yellow),
            //     Spacer(),
            //     buildFilterWidget("Price", AppPalette.lightGrey2),
            //     Spacing.horizontalSpace(10),
            //     buildFilterWidget(
            //         "Filters", AppPalette.lightGrey2, Icons.filter_list),
            //   ],
            // ),
            Text("Popular Now", style: TypoBlack.black70018),
            Flexible(
              child: GridView.builder(
                  itemCount: productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8, // Adjust spacing if needed
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.65, // Adjust aspect ratio if needed
                  ),
                  itemBuilder: (context, index) => WishlistProductCardWidget(
                        productImage: productList[index],
                        productName: "Phone",
                      )),
            )
          ],
        ),
      ),
    );
  }

  Card buildFilterWidget(String name, Color color,
      [IconData icon = Icons.keyboard_arrow_down]) {
    return Card(
      elevation: 0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          spacing: 10,
          children: [
            Text(name, style: TypoBlack.black60014),
            Icon(icon, color: AppPalette.black)
          ],
        ),
      ),
    );
  }
}
