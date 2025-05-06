import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/repo/coupon-card-repo/coupon_card_repo.dart';
import 'package:get/get.dart';

import '../../../model/coupon-model/discount_info_model.dart';

class CouponCardController extends GetxController {
  Rx<Status> kDiscountInfoLoading = Rx(Status.initial);

  RxList<DiscountInfoModel> kDiscountInfoList = <DiscountInfoModel>[].obs;

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
}
