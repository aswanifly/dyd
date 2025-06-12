import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/feature/cart/screen/cart_screen.dart';
import 'package:dyd/feature/landing/controller/landing_controller.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';
import 'package:dyd/model/hotdeals-model/hot_deals_model.dart';
import 'package:dyd/model/product-model/all_product_model.dart';
import 'package:dyd/model/product-model/product_model.dart';
import 'package:dyd/model/product-model/related_product_model.dart';
import 'package:dyd/model/wish-list-model/wish_list_model.dart';
import 'package:dyd/repo/cart-repo/cart_repo.dart';
import 'package:dyd/repo/product-repo/product_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../core/widget/snackbar/getx_snackbar_widget.dart';
import '../../../model/product-model/product_detail_model.dart';

class ProductController extends GetxController {
  RxBool kIsAddedToCart = false.obs;
  Rx<Status> kLoadingProductsList = Rx(Status.initial);
  Rx<Status> kLoadingProductsDetail = Rx(Status.initial);
  Rx<Status> kLoadingAddToCard = Rx(Status.initial);
  Rx<Status> kProductListLoading = Rx(Status.initial);
  Rx<Status> kHotDealsLoading = Rx(Status.initial);
  Rx<Status> kWishListLoading = Rx(Status.initial);
  Rx<Status> kAddWishListLoading = Rx(Status.initial);
  Rx<Status> kRemoveWishListLoading = Rx(Status.initial);
  Rx<Status> kRelatedProductListLoading = Rx(Status.initial);

  Rx<Status> kGetUserWishList = Rx(Status.initial);
  Rx<ProductDetailModel?> kProductDetailModel = Rx(null);
  RxList<RelatedProductModel> kRelatedProductList = <RelatedProductModel>[].obs;
  RxList<HotDealsModel> kHotDealsList = <HotDealsModel>[].obs;

  //product list
  RxList<ProductModel> kProductList = <ProductModel>[].obs;
  RxList<ProductModel> originalProductList = <ProductModel>[].obs;
  RxList<AllProductModel> kAllProductList = <AllProductModel>[].obs;
  RxList<AllProductModel> kAllProductSearchList = <AllProductModel>[].obs;
  RxList<WishListProductModel> kWishList = <WishListProductModel>[].obs;
  RxString productsearch = ''.obs;
  TextEditingController searchFilter = TextEditingController();

  RxBool isWishlisted = false.obs;

  Future<void> fGetHotDeals() async {
    try {
      kHotDealsLoading(Status.loading);
      final res = await ProductRepo.fGetHotDeals();
      kHotDealsList.clear();
      kHotDealsList.addAll(res);
      kHotDealsLoading(Status.success);
    } catch (e) {
      kHotDealsLoading(Status.error);
    }
  }

  Future<void> fGetProductByCategory(String categoryId) async {
    try {
      kLoadingProductsList(Status.loading);
      final res = await ProductRepo.fGetProductByCategory(categoryId);
      originalProductList.assignAll(res);
      kProductList.clear();
      kProductList.addAll(res);
      kLoadingProductsList(Status.success);
    } catch (e) {
      print(e);
      kProductList.clear();
      kLoadingProductsList(Status.error);
    }
  }

  Future<void> fGetRelatedProducts(String productId) async {
    try {
      kRelatedProductListLoading(Status.loading);
      final res = await ProductRepo.fGetRelatedProducts(productId);
      kRelatedProductList.clear();
      kRelatedProductList.addAll(res);

      kRelatedProductListLoading(Status.success);
    } catch (e) {
      print(e);
      kRelatedProductList.clear();
      kRelatedProductListLoading(Status.error);
    }
  }

  void filterProductByName(String query) {
    if (query.trim().isEmpty) {
      kProductList.assignAll(originalProductList);
    } else {
      kProductList.assignAll(
        originalProductList.where(
          (p) => p.productName.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  void filterAllProductByName(String query) {
    if (query.trim().isEmpty) {
      kAllProductList.assignAll(kAllProductSearchList);
    } else {
      kAllProductList.assignAll(
        kAllProductSearchList.where(
          (p) => p.productName.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  Future<void> fGetAllProductsList() async {
    try {
      Map<String, dynamic> data = {
        "page": 1,
        "limit": 50,
        "search": "",
      };
      kProductListLoading(Status.loading);
      final res = await ProductRepo.fGetAllProducts(data);
      kAllProductSearchList.assignAll(res);
      kAllProductList.clear();
      kAllProductList.addAll(res);

      kProductListLoading(Status.success);
    } catch (e) {
      print(e);
      kAllProductList.clear();
      kProductListLoading(Status.error);
    }
  }

  Future<void> fGetWishList() async {
    try {
      Map<String, dynamic> data = {"sortBy": ""};
      kWishListLoading(Status.loading);
      final res = await ProductRepo.fGetWishList(data);
      kWishList.clear();
      kWishList.addAll(res);
      kWishListLoading(Status.success);
    } catch (e) {
      print(e);
      kWishList.clear();
      kWishListLoading(Status.error);
    }
  }

  //PRODUCT DETAIL
  Future<void> fGetProductsDetails(String productId) async {
    try {
      kLoadingProductsDetail(Status.loading);
      final res = await ProductRepo.fGetProductDetail(productId);
      kProductDetailModel(res);

      kLoadingProductsDetail(Status.success);
    } catch (e) {
      print(e);
      kProductList.clear();
      kLoadingProductsDetail(Status.error);
    }
  }

  Future<void> addToWhishList(BuildContext context, String productId) async {
    try {
      kAddWishListLoading(Status.loading);
      final response = await ProductRepo.addToWhishList(productId);
      Logger().i(response.response);

      kAddWishListLoading(Status.success);
      fGetProductsDetails(productId);

      if (context.mounted) {
        showCustomSnackBar(context, response.response['message']);
      }
    } catch (e) {
      kAddWishListLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  Future<void> removeFromWhishList(
      BuildContext context, String productId) async {
    try {
      kRemoveWishListLoading(Status.loading);
      final response = await ProductRepo.removeFromWhishList(productId);
      Logger().i(response.response);

      kRemoveWishListLoading(Status.success);
      fGetProductsDetails(productId);

      if (context.mounted) {
        showCustomSnackBar(context, response.response['message']);
      }
    } catch (e) {
      kRemoveWishListLoading(Status.error);
      if (context.mounted) {
        // ErrorHelper.handleExceptions(context: context, exception: e);
      }
    }
  }

  //ADD TO CART
  Future<void> fAddProductToCart() async {
    int price = kProductDetailModel.value!.salePrice.isEmpty
        ? 0
        : int.parse(kProductDetailModel.value!.salePrice);

    try {
      Map<String, dynamic> data = {
        "product": kProductDetailModel.value!.id,
        "productName": kProductDetailModel.value!.productName,
        "price": price,
        "purchaseQuantity": kProductDetailModel.value!.qty,
        "discount": "0",
        "gst": "",
        "subTotal": price,
        "finalPrice": price,
        "address": ""
      };
      kLoadingAddToCard(Status.loading);
      final res = await CartRepo.fAddProductToCart(data);
      Logger().w(res.response);
      kLoadingAddToCard(Status.success);

      SnackBarGetXUtils.show(message: res.response["message"]);
      if (res.response["message"] == "Item added to cart successfully") {
        Get.offAll(() => NavigationScreen(
              showSplash: false,
            ));
        Get.find<LandingController>().kCurrentScreenIndex(2);
      } else {
        return;
      }
    } catch (e) {
      Logger().e(e);
      kLoadingAddToCard(Status.error);
    }
  }

  //ADD TO CART
  Future<void> fAddtoCart({
    required String productId,
    required String productName,
    required String salePrice,
    required String qyt,
    required String discount,
    required String basePrice,
  }) async {
    try {
      Map<String, dynamic> data = {
        "product": productId,
        "productName": productName,
        "price": basePrice,
        "purchaseQuantity": 1,
        "discount": "0",
        "gst": "",
        "subTotal": basePrice,
        "finalPrice": salePrice,
        "address": ""
      };
      kLoadingAddToCard(Status.loading);
      final res = await CartRepo.fAddProductToCart(data);
      Logger().w(res.response);
      kLoadingAddToCard(Status.success);

      SnackBarGetXUtils.show(message: res.response["message"]);
      if (res.response["message"] == "Item added to cart successfully") {
        Get.find<LandingController>().kCurrentScreenIndex(2);
      } else {
        return;
      }
    } catch (e) {
      Logger().e(e);
      kLoadingAddToCard(Status.error);
    }
  }
}
