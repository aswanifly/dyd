import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/repo/home-repo/home_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../model/home-model/home_shopping_category_model.dart';

class HomeController extends GetxController {
  Rx<Status> kShoppingCategoryLoading = Rx(Status.initial);

  RxBool kIsCouponScreen = true.obs;

  RxList<HomeShoppingCategoryModel> kHomeShoppingCategoryList =
      <HomeShoppingCategoryModel>[].obs;

  void fToggleHomeScreen() {
    kIsCouponScreen(!kIsCouponScreen.value);
  }

  void fCallFunctions() {
    fGetHomeCategory();
  }

  Future<void> fGetHomeCategory() async {
    try {
      kShoppingCategoryLoading(Status.loading);
      final response = await HomeRepo.fGetHomeListOfCategories();
      kHomeShoppingCategoryList.clear();
      kHomeShoppingCategoryList.addAll(response);
      kShoppingCategoryLoading(Status.success);
    } catch (e) {
      kHomeShoppingCategoryList.clear();
      kShoppingCategoryLoading(Status.error);
      print(e);
    }
  }
}
