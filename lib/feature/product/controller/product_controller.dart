import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/model/product-model/product_model.dart';
import 'package:dyd/repo/product-repo/product_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../core/widget/snackbar/getx_snackbar_widget.dart';
import '../../../model/product-model/product_detail_model.dart';

class ProductController extends GetxController {
  RxBool kIsAddedToCart = false.obs;
  Rx<Status> kLoadingProductsList = Rx(Status.initial);
  Rx<Status> kLoadingProductsDetail = Rx(Status.initial);
  Rx<Status> kLoadingAddToCard = Rx(Status.initial);

  Rx<ProductDetailModel?> kProductDetailModel = Rx(null);

  //product list
  RxList<ProductModel> kProductList = <ProductModel>[].obs;

  Future<void> fGetProductByCategory(String categoryId) async {
    try {
      kLoadingProductsList(Status.loading);
      final res = await ProductRepo.fGetProductByCategory(categoryId);
      kProductList.clear();
      kProductList.addAll(res);
      kLoadingProductsList(Status.success);
    } catch (e) {
      print(e);
      kProductList.clear();
      kLoadingProductsList(Status.error);
    }
  }

  //PRODUCT DETAIL
  Future<void> fGetProductDetail(String productId) async {
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
        "discount": kProductDetailModel.value!.discount,
        "gst": "",
        "subTotal": price,
        "finalPrice": price,
        "address": ""
      };
      kLoadingAddToCard(Status.loading);
      final res = await ProductRepo.fAddProductToCart(data);
      Logger().w(res.response);
      kLoadingAddToCard(Status.success);
      SnackBarGetXUtils.show(message: res.response["message"]);
    } catch (e) {
      Logger().e(e);
      kLoadingAddToCard(Status.error);
    }
  }
}
