import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/model/lucky-card-model/lucky_card_model.dart';
import 'package:dyd/repo/coupon-card-repo/coupon_card_repo.dart';
import 'package:get/get.dart';

import '../../../model/coupon-model/discount_info_model.dart';

class CouponCardController extends GetxController {
  Rx<Status> kDiscountInfoLoading = Rx(Status.initial);
  Rx<Status> kLuckyCardLoading = Rx(Status.initial);

  RxList<DiscountInfoModel> kDiscountInfoList = <DiscountInfoModel>[].obs;
  RxList<LuckyCardModel> kLuckyCardsList = <LuckyCardModel>[].obs;

  Future<void> fGetDiscountInfo() async {
    try {
      kDiscountInfoLoading(Status.loading);
      final res = await CouponCardRepo.fGetDiscountDetail();
      kDiscountInfoList.clear();
      kDiscountInfoList.addAll(res);
      kDiscountInfoLoading(Status.success);
    } catch (e) {
      kDiscountInfoLoading(Status.error);
    }
  }

  Future<void> fGetLuckyCard({required String filterType}) async {
    try {
      kLuckyCardLoading(Status.loading);
      final res = await CouponCardRepo.fGetLuckyCard(
        filterType: filterType,
      );
      kLuckyCardsList.clear();
      kLuckyCardsList.addAll(res);
      kDiscountInfoLoading(Status.success);
    } catch (e) {
      kDiscountInfoLoading(Status.error);
    }
  }
}
