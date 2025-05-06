import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_grey_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/green_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/red_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/widget/button-widget/c_gradient_material_button_widget.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/feature/cart/screen/cart_screen.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/model/product-model/product_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/widget/app-bar-widget/app-bar-widget.dart';
import '../../../core/widget/loader/circular_progress_loader.dart';
import '../../../core/widget/loader/overlay_loader_widget.dart';
import '../../../core/widget/snackbar/getx_snackbar_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productController = Get.find<ProductController>();

  @override
  void initState() {
    productController.fGetProductDetail(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayLoaderWidget(
          isLoading:
              productController.kLoadingAddToCard.value == Status.loading,
          widget: Scaffold(
            appBar: GradientAppBar(
              title: Text("Product Detail"),
            ),
            body: Obx(() =>
                productController.kLoadingProductsDetail.value == Status.loading
                    ? CLoadingCircularLoader()
                    : checkConditionForProductDetailData(context)),
            bottomNavigationBar: Obx(() =>
                productController.kLoadingProductsDetail.value == Status.loading
                    ? SizedBox()
                    : buildBuyButtonsWidget(context)),
          ),
        ));
  }

  Widget checkConditionForProductDetailData(BuildContext context) {
    return productController.kProductDetailModel.value == null ||
            productController.kLoadingProductsDetail.value == Status.error
        ? Center(
            child: Text("Could not get product detail",
                style: TypoBlack.black50014),
          )
        : buildProductDetailDataWidget(context);
  }

  Widget buildProductDetailDataWidget(BuildContext context) {
    final productDetailModel = productController.kProductDetailModel.value!;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCarouselSliderWidget(context),
          Spacing.verticalSpace(10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productDetailModel.productName,
                        style: TypoBlack.black50014),
                    Icon(Icons.favorite_border, color: AppPalette.black)
                  ],
                ),
                Spacing.verticalSpace(10),
                buildRatingWidget(),
                Spacing.verticalSpace(10),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text:
                        "${ConstantText.rupeeSymbol}${productDetailModel.salePrice} ",
                    style: TypoRed.red70018,
                    children: [
                      TextSpan(
                        text:
                            '${ConstantText.rupeeSymbol}${productDetailModel.basePrice}',
                        style: LightGreyTypo.lightGrey40014LineThrough,
                      ),
                    ],
                  ),
                ),
                Spacing.verticalSpace(10),
                buildDottedBorderOfferCardWidget(),
                Spacing.verticalSpace(10),
                buildStockStatusWidget(productDetailModel),
                Spacing.verticalSpace(10),
                Text("Description", style: TypoBlack.black70018),
                Spacing.verticalSpace(10),
                Text(
                  productDetailModel.description,
                  style: TypoDarkGrey.darkGrey40014,
                  textAlign: TextAlign.start,
                ),
                Spacing.verticalSpace(10),
                Text("You may also like", style: TypoBlack.black70018),
                Spacing.verticalSpace(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(4, (i) => buildMayLikeCardWidget()),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //add to card and buy button
  Widget buildBuyButtonsWidget(BuildContext context) {
    // final productController = Get.find<ProductController>();
    return Obx(() {
      final productModel = productController.kProductDetailModel.value!;
      return SizedBox(
          height: 70,
          width: double.infinity,
          child: productModel.isAddedToCard && productModel.qty > 0
              ? buildCartAndGoToCartButtonWidget(context)
              : buildAddToCartAndBuyNowButtonWidget(productController));
    });
  }

  //buy now and add to cart Button
  Row buildAddToCartAndBuyNowButtonWidget(
      ProductController productDetailController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CMaterialButton(
          height: 40,
          minWidth: 140,
          color: AppPalette.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppPalette.darkViolet, width: 2)),
          child: Text("Add to cart", style: TypoDarkViolet.darkViolet50015),
          onPressed: () {
            // productDetailController.kIsAddedToCart(true);
            final model = productController.kProductDetailModel.value!;
            final updatedModel =
                model.copyWith(isAddedToCard: true, qty: model.qty + 1);
            productController.kProductDetailModel(updatedModel);
            productController.fAddProductToCart();
          },
        ),
        CGradientMaterialButton(
          height: 40,
          minWidth: 140,
          color: AppPalette.darkViolet,
          child: Text(
            "Buy now",
            style: TypoWhite.white50015,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Row buildCartAndGoToCartButtonWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 48,
          width: 140,
          child: Card(
            elevation: 0,
            color: AppPalette.darkViolet,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    final model = productController.kProductDetailModel.value!;
                    if (model.qty == 0) {
                      return;
                    }

                    final updatedModel = model.copyWith(
                        isAddedToCard: model.qty == 1 ? false : true,
                        qty: model.qty - 1);
                    productController.kProductDetailModel(updatedModel);
                  },
                  child: Icon(
                    Icons.remove,
                    color: AppPalette.white,
                    size: 20,
                  ),
                ),
                Text(
                  "${productController.kProductDetailModel.value!.qty}",
                  style: TypoWhite.white50015,
                ),
                GestureDetector(
                  onTap: () {
                    final model = productController.kProductDetailModel.value!;
                    final updatedModel = model.copyWith(qty: model.qty + 1);
                    productController.kProductDetailModel(updatedModel);
                  },
                  child: Icon(
                    Icons.add,
                    color: AppPalette.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
        CMaterialButton(
          height: 40,
          minWidth: 140,
          color: AppPalette.darkViolet,
          child: Text(
            "Proceed to cart",
            style: TypoWhite.white50015,
          ),
          onPressed: () => context.pushFadedTransition(CartScreen()),
        ),
      ],
    );
  }

  //may you like cards
  Card buildMayLikeCardWidget() {
    return Card(
      color: AppPalette.white,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CNetworkImageRectangularWithTextWidget(
            imageLink:
                'https://cdn.pixabay.com/photo/2022/06/21/21/15/audio-7276511_1280.jpg',
            name: "",
            height: 130,
            width: 130,
            borderRadius: BorderRadius.circular(8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Wireless Earbuds", style: TypoBlack.black40014),
                Text("${ConstantText.rupeeSymbol}100",
                    style: TypoDarkViolet.darkViolet50015)
              ],
            ),
          )
        ],
      ),
    );
  }

  DottedBorder buildDottedBorderOfferCardWidget() {
    return DottedBorder(
        color: AppPalette.yellow,
        strokeWidth: 3,
        dashPattern: [5, 4],
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        child: ColoredBox(
          color: AppPalette.yellow.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: [
                SvgPicture.asset(ImageHelper.bnProductDetail),
                Spacing.horizontalSpace(10),
                Text("Get it for ${ConstantText.rupeeSymbol}100 + Iphone",
                    style: TypoBlack.black40014),
                Spacing.horizontalSpace(10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ],
            ),
          ),
        ));
  }

  Row buildStockStatusWidget(ProductDetailModel productDetailModel) {
    return Row(
      children: [
        Icon(
          Icons.fiber_manual_record_rounded,
          color: AppPalette.green,
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: "In Stock\t\t",
            style: GreenTypo.green50016,
            children: [
              TextSpan(
                text: productDetailModel.quantity < 15
                    ? '(${productDetailModel.quantity} unit left)'
                    : "",
                style: TypoDarkGrey.darkGrey40014,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildRatingWidget() {
    return Row(
      children: [
        ...List.generate(
            4,
            (i) => Icon(
                  Icons.star,
                  color: AppPalette.yellow,
                )),
        Spacing.horizontalSpace(8),
        Text("(234 reviews)", style: TypoBlack.black40014)
      ],
    );
  }

  //carousel slider widget
  Stack buildCarouselSliderWidget(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.4),
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    CachedNetworkImage(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2016/09/09/22/40/bike-1658214_1280.jpg',
            ),
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              reverse: false,
              viewportFraction: 1,
              aspectRatio: 1,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
              radius: 18,
              backgroundColor: AppPalette.white,
              child: Icon(
                Icons.share_outlined,
                color: AppPalette.black,
                size: 20,
              )),
        )
      ],
    );
  }
}
