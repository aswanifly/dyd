import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/model/home-model/available_draws_model.dart';
import 'package:dyd/model/home-model/recent_winner_model.dart';
import 'package:dyd/repo/home-repo/home_repo.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../model/home-model/home_shopping_category_model.dart';

class HomeController extends GetxController {
  Rx<Status> kShoppingCategoryLoading = Rx(Status.initial);
  Rx<Status> kRecentWinnersLoadingStatus = Rx(Status.initial);
  Rx<Status> kAvailableDrawsLoadingStatus = Rx(Status.initial);

  RxBool kIsCouponScreen = true.obs;

  RxList<HomeShoppingCategoryModel> kHomeShoppingCategoryList =
      <HomeShoppingCategoryModel>[].obs;
  RxList<RecentWinnerModel> kRecentWinnerList = <RecentWinnerModel>[].obs;
  RxList<AvailableDrawsModel> kAvailableDraws = <AvailableDrawsModel>[].obs;

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

  Future<void> fGetRecentWinnerList() async {
    try {
      kRecentWinnersLoadingStatus(Status.loading);
      final response = await HomeRepo.fGetRecentWinnerList();
      kRecentWinnerList.clear();
      kRecentWinnerList.addAll(response);
      kRecentWinnersLoadingStatus(Status.success);
    } catch (e) {
      kRecentWinnerList.clear();
      kShoppingCategoryLoading(Status.error);
      print(e);
    }
  }

  Future<void> fGetAvailableDraws() async {
    try {
      kAvailableDrawsLoadingStatus(Status.loading);
      final response = await HomeRepo.fGetAvailableDraws();
      kAvailableDraws.clear();
      kAvailableDraws.addAll(response);
      kAvailableDrawsLoadingStatus(Status.success);
    } catch (e) {
      kAvailableDraws.clear();
      kAvailableDrawsLoadingStatus(Status.error);
      print(e);
    }
  }
}
