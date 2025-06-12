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
  final String? categoryId;

  const ProductListScreen({super.key, this.categoryId});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final productController = Get.find<ProductController>();
  final homeController = Get.find<HomeController>();

  String selectedCategoryId = ''; // Maintain selected category

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.categoryId ?? '';
    if (selectedCategoryId.isNotEmpty) {
      productController.fGetProductByCategory(selectedCategoryId);
    } else {
      productController.fGetAllProductsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text("Categories"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CSearchBar(
              onChanged: (String value) {
                selectedCategoryId.isEmpty
                    ? productController.filterAllProductByName(value)
                    : productController.filterProductByName(value);
              },
              controller: productController.searchFilter,
            ),
            Text("Categories", style: TypoBlack.black70018),
            buildCategoryListWidget(),
            Spacing.verticalSpace(2),
            Text("Popular now", style: TypoBlack.black70018),
            Obx(() =>
                productController.kLoadingProductsList.value == Status.loading
                    ? CLoadingCircularLoader()
                    : buildProductDataWidget()),
          ],
        ),
      ),
    );
  }

  Widget buildProductDataWidget() {
    return Flexible(
      child: Obx(() {
        final activeCategories = productController.kProductList
            .where((element) => element.isActive)
            .toList();
        final activeProducts = productController.kAllProductList
            .where((element) => element.isActive)
            .toList();

        return GridView.builder(
            itemCount: selectedCategoryId.isNotEmpty
                ? activeCategories.length
                : activeProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final productModel = selectedCategoryId.isNotEmpty
                  ? activeCategories[index]
                  : activeProducts[index];
              return ProductCardWidget(productModel: productModel);
            });
      }),
    );
  }

  Widget buildCategoryListWidget() {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.kHomeShoppingCategoryList.length,
        itemBuilder: (ctx, index) {
          final model = homeController.kHomeShoppingCategoryList[index];
          final isSelected = selectedCategoryId == model.id;

          return CategoryChipWidget(
            label: model.category,
            selected: isSelected,
            onTap: () {
              setState(() {
                if (selectedCategoryId == model.id) {
                  selectedCategoryId = '';
                  productController.fGetAllProductsList();
                } else {
                  selectedCategoryId = model.id;
                  productController.fGetProductByCategory(selectedCategoryId);
                }
              });
            },
          );
        },
      ),
    );
  }
}
