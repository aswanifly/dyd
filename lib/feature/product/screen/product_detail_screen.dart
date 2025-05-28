import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dyd/core/config/asset-image-path/asset_image_path.dart';
import 'package:dyd/core/config/navigation-helper/navigation_helper.dart';
import 'package:dyd/core/config/spacing/dynamic_spacing_widget.dart';
import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
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
import 'package:dyd/feature/lucky-card/controller/discount_card_controller.dart';
import 'package:dyd/feature/lucky-card/screen/discount_cards_list_screen.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/model/product-model/product_detail_model.dart';
import 'package:dyd/model/product-model/related_product_model.dart';
import 'package:dyd/model/ticket-model/ticket_details_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
  final discountCard = Get.put(CouponCardController());

  @override
  void initState() {
    productController.fGetProductsDetails(widget.productId);
    productController.fGetRelatedProducts(widget.productId);
    discountCard.fGetDiscountCard();
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
          productDetailModel.images.isEmpty
              ? Text("data")
              : buildCarouselSliderWidget(context, productDetailModel.images),
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
                    InkWell(
                      onTap: () {
                        if (productDetailModel.isWishlisted == true) {
                          productController.removeFromWhishList(
                              context, productDetailModel.id);
                        } else {
                          productController.addToWhishList(
                              context, productDetailModel.id);
                        }
                      },
                      child: Icon(
                        productDetailModel.isWishlisted == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: productDetailModel.isWishlisted == true
                            ? AppPalette.red
                            : AppPalette.black,
                      ),
                    )
                  ],
                ),
                Spacing.verticalSpace(10),
                // buildRatingWidget(),
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
                if (discountCard.kDiscountInfoList.isNotEmpty)
                  InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            showDragHandle: true,
                            backgroundColor: AppPalette.whiteShade,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 10,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: AppPalette.darkGrey2),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppPalette.blueishWhiteShade1,
                                                  AppPalette.blueishWhiteShade2,
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                spacing: 15,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CNetworkImageRectangularWithTextWidget(
                                                        height: 80,
                                                        width: 80,
                                                        imageLink: discountCard
                                                                .kDiscountInfoList[
                                                                    0]
                                                                .image
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2025/03/29/10/59/ryoan-ji-9500830_1280.jpg"
                                                            : "$IMAGE_URL${discountCard.kDiscountInfoList[0].image}",
                                                        name: discountCard
                                                            .kDiscountInfoList[
                                                                0]
                                                            .name[0],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      Spacing.horizontalSpace(
                                                          10),
                                                      Expanded(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          spacing: 5,
                                                          children: [
                                                            Text(
                                                                discountCard
                                                                    .kDiscountInfoList[
                                                                        0]
                                                                    .name,
                                                                style: TypoBlack
                                                                    .black70024),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Card(
                                                    color: AppPalette.white,
                                                    elevation: 0,
                                                    margin: EdgeInsets.zero,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Row(
                                                        spacing: 10,
                                                        children: [
                                                          Icon(
                                                            Icons.access_time,
                                                            color: AppPalette
                                                                .darkGrey,
                                                          ),
                                                          Text(
                                                            DateFormat(
                                                                    'MMM dd, yyyy')
                                                                .format(DateTime
                                                                    .parse(
                                                              discountCard
                                                                  .kDiscountInfoList[
                                                                      0]
                                                                  .endDate,
                                                            )),
                                                            style: TypoBlack
                                                                .black40014,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Spacing.verticalSpace(10),
                                          Text("Terms & Condition",
                                              style: TypoBlack.black60016),
                                          Text("•\tTerms 1 is Lorem",
                                              style: TypoBlack.black40014),
                                          Text("•\tTerms 1 is Lorem",
                                              style: TypoBlack.black40014),
                                          Text("•\tTerms 1 is Lorem",
                                              style: TypoBlack.black40014),
                                          Text("Read more",
                                              style: TypoDarkViolet
                                                  .darkViolet50016),
                                          Spacing.verticalSpace(10),
                                          CGradientMaterialButton(
                                            onPressed: () {
                                              discountCard
                                                  .checkActiveDiscountCard(
                                                      fromScreen:
                                                          "productDetails",
                                                      context);
                                            },
                                            child: Text("Buy Now",
                                                style: TypoWhite.white70016),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: buildDottedBorderOfferCardWidget()),
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
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: productController.kRelatedProductList.length,
                      itemBuilder: (BuildContext context, index) {
                        final relatedProducts =
                            productController.kRelatedProductList[index];
                        return buildMayLikeCardWidget(relatedProducts);
                      }),
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
            // productController.fAddProductToCart();
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
          onPressed: () async {
            final couponCardController = Get.find<CouponCardController>();
            bool isActive = await couponCardController
                .checkDiscountCardFromProductBuy(context);

            if (isActive) {
              final model = productController.kProductDetailModel.value!;
              final updatedModel =
                  model.copyWith(isAddedToCard: true, qty: model.qty + 1);
              productController.kProductDetailModel(updatedModel);
              productController.fAddProductToCart();
            } else {
              Get.to(() => DiscountCardListScreen());
            }
          },
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
          onPressed: () async {
            final couponCardController = Get.find<CouponCardController>();
            bool isActive = await couponCardController
                .checkDiscountCardFromProductBuy(context);

            if (isActive) {
              productController.fAddProductToCart();
            } else {
              Get.to(() => DiscountCardListScreen());
            }
          },
        ),
      ],
    );
  }

  //may you like cards
  Card buildMayLikeCardWidget(RelatedProductModel relatedProducts) {
    return Card(
      color: AppPalette.white,
      elevation: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CNetworkImageRectangularWithTextWidget(
            imageLink: relatedProducts.image!.isEmpty
                ? 'https://cdn.pixabay.com/photo/2022/06/21/21/15/audio-7276511_1280.jpg'
                : "$IMAGE_URL${relatedProducts.image!}",
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
                Text(relatedProducts.productName!, style: TypoBlack.black40014),
                Text("${ConstantText.rupeeSymbol}${relatedProducts.basePrice}",
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

  // Row buildRatingWidget() {
  //   return Row(
  //     children: [
  //       ...List.generate(
  //           4,
  //           (i) => Icon(
  //                 Icons.star,
  //                 color: AppPalette.yellow,
  //               )),
  //       Spacing.horizontalSpace(8),
  //       Text("(234 reviews)", style: TypoBlack.black40014)
  //     ],
  //   );
  // }

  //carousel slider widget
  Stack buildCarouselSliderWidget(BuildContext context, List<String> images) {
    return Stack(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.4),
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) =>
                    CachedNetworkImage(
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: "$IMAGE_URL${images[itemIndex]}",
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
