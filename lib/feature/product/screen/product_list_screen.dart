import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/widget/app-bar-widget/app-bar-widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/home/controller/home_controller.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/feature/product/widget/chip_widget.dart';
import 'package:dyd/feature/product/widget/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widget/loader/circular_progress_loader.dart';
import '../../../core/widget/text-field-widget/search_text_field_widget.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryId;

  const ProductListScreen({super.key, required this.categoryId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productController = Get.find<ProductController>();

  @override
  void initState() {
    productController.fGetProductByCategory(widget.categoryId);
    super.initState();
  }

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
      appBar: GradientAppBar(title: Text("Categories"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            // CSearchBar(onChanged: (String v) {}),
            Text("Categories", style: TypoBlack.black70018),
            buildCategoryListWidget(),
            Spacing.verticalSpace(2),
            Text("Popular now", style: TypoBlack.black70018),
            Obx(
              () =>
                  productController.kLoadingProductsList.value == Status.loading
                      ? CLoadingCircularLoader()
                      : buildProductDataWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProductDataWidget() {
    return Flexible(
        child: productController.kProductList.isEmpty
            ? Center(
                child: Text("No Products", style: TypoBlack.black50014),
              )
            : GridView.builder(
                itemCount: productController.kProductList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8, // Adjust spacing if needed
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8, // Adjust aspect ratio if needed
                ),
                itemBuilder: (context, index) {
                  final productModel = productController.kProductList[index];
                  return ProductCardWidget(
                    productModel: productModel,
                  );
                }));
  }

  SizedBox buildCategoryListWidget() {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              Get.find<HomeController>().kHomeShoppingCategoryList.length,
          itemBuilder: (ctx, index) {
            final model =
                Get.find<HomeController>().kHomeShoppingCategoryList[index];
            return CategoryChipWidget(
              label: model.category,
              onTap: () => productController.fGetProductByCategory(model.id),
            );
          }),
    );
  }
}
