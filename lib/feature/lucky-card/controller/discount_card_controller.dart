import 'package:dyd/core/config/spacing/static_spacing_helper.dart';
import 'package:dyd/core/config/theme/app_palette.dart';
import 'package:dyd/core/constant/app-loading-state/app_loading_status.dart';
import 'package:dyd/core/constant/app_constant.dart';
import 'package:dyd/core/constant/text.dart';
import 'package:dyd/core/typo/black_typo.dart';
import 'package:dyd/core/typo/dark_violet_typo.dart';
import 'package:dyd/core/typo/light_grey_typo.dart';
import 'package:dyd/core/typo/white_typo.dart';
import 'package:dyd/core/utils/date_utils.dart';
import 'package:dyd/core/widget/button-widget/c_material_button_widget.dart';
import 'package:dyd/core/widget/image-widget/c_circular_cached_image_widget.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:dyd/feature/cart/screen/cart_screen.dart';
import 'package:dyd/feature/home/screen/home_screen.dart';
import 'package:dyd/feature/landing/controller/landing_controller.dart';
import 'package:dyd/feature/landing/screen/landing_screen.dart';
import 'package:dyd/feature/lucky-card/screen/lucky_card_screen.dart';
import 'package:dyd/feature/order/widget/order_summary_screen.dart';
import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:dyd/model/cart-model/cart_model.dart';
import 'package:dyd/model/coupon-model/check_active_discount_model.dart';
import 'package:dyd/model/coupon-model/discount_model.dart';
import 'package:dyd/model/lucky-card-model/lucky_card_model.dart';
import 'package:dyd/model/ticket-model/ticket_details_info_model.dart';
import 'package:dyd/model/ticket-model/ticket_model.dart';
import 'package:dyd/repo/coupon-card-repo/coupon_card_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/coupon-model/discount_info_model.dart';

class CouponCardController extends GetxController {
  Rx<Status> kDiscountInfoLoading = Rx(Status.initial);
  Rx<Status> kLuckyCardLoading = Rx(Status.initial);
  Rx<Status> kbuyDiscountCardLoading = Rx(Status.initial);
  Rx<Status> kButExtraTicketsLoading = Rx(Status.initial);
  Rx<Status> kDiscountCardLoading = Rx(Status.initial);
  Rx<Status> kCheckActiveLoading = Rx(Status.initial);
  Rx<Status> kTicketDetailInfoLoading = Rx(Status.initial);
  RxList<DiscountInfoModel> kDiscountInfoList = <DiscountInfoModel>[].obs;
  RxList<TicketModel> kLuckyCardsList = <TicketModel>[].obs;
  RxList<DiscountCardModel> kDiscountCardsList = <DiscountCardModel>[].obs;
  RxString discountCardId = "".obs;
  RxString luckyFilterType = "all".obs;
  RxString discountCardFilters = "all".obs;
  RxBool isActive = false.obs;
  Rx<TicketDetailsInfoModel?> kTicketDetailInfo = Rx(null);

  DiscountInfoModel? discountInfoModel;
  RxInt quantity = 1.obs;

  Future<void> fGetDiscountCard() async {
    try {
      kDiscountInfoLoading(Status.loading);
      final res = await CouponCardRepo.fGetDiscountCard();
      kDiscountInfoList.clear();
      kDiscountInfoList.addAll(res);
      kDiscountInfoLoading(Status.success);
    } catch (e) {
      kDiscountInfoLoading(Status.error);
    }
  }

  Future<void> fGetLuckyCard() async {
    try {
      kLuckyCardLoading(Status.loading);
      final res = await CouponCardRepo.fGetLuckyCard(
        filterType: luckyFilterType.value,
      );
      kLuckyCardsList.clear();
      kLuckyCardsList.addAll(res);
      kDiscountInfoLoading(Status.success);
    } catch (e) {
      kDiscountInfoLoading(Status.error);
    }
  }

  Future<void> fGetTicketDetailInfo(
      BuildContext context, String ticketId) async {
    try {
      kTicketDetailInfoLoading(Status.loading);
      final res = await CouponCardRepo.fGetTicketDetailInfo(ticketId);
      kTicketDetailInfo(res);
      showModalBottomSheet(
          showDragHandle: true,
          backgroundColor: AppPalette.whiteShade,
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppPalette.darkGrey2),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 15,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CNetworkImageRectangularWithTextWidget(
                                      height: 80,
                                      width: 80,
                                      imageLink: kTicketDetailInfo
                                              .value!.images![0].isEmpty
                                          ? ""
                                          : "$IMAGE_URL${kTicketDetailInfo.value!.images![0]}",
                                      name: kTicketDetailInfo
                                          .value!.ticketNumber![0],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    Spacing.horizontalSpace(10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5,
                                        children: [
                                          Text(
                                              kTicketDetailInfo
                                                  .value!.ticketNumber!,
                                              style: TypoBlack.black70024),
                                          Text(
                                              kTicketDetailInfo
                                                  .value!.discountCard!.name!,
                                              style:
                                                  LightGreyTypo.lightGrey40014)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  color: AppPalette.white,
                                  elevation: 0,
                                  margin: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: AppPalette.darkGrey,
                                        ),
                                        Text(
                                          DateFormat('MMM dd, yyyy').format(
                                              DateTime.parse(kTicketDetailInfo
                                                  .value!.drawExpiryDate!
                                                  .toIso8601String())),
                                          style: TypoBlack.black40014,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacing.verticalSpace(10),
                        Text("Terms & Condition", style: TypoBlack.black60016),
                        Text("•\tTerms 1 is Lorem",
                            style: TypoBlack.black40014),
                        Text("•\tTerms 1 is Lorem",
                            style: TypoBlack.black40014),
                        Text("•\tTerms 1 is Lorem",
                            style: TypoBlack.black40014),
                        Text("Read more",
                            style: TypoDarkViolet.darkViolet50016),
                        Spacing.verticalSpace(10),
                        buildCartAndGoToCartButtonWidget(
                            context, kTicketDetailInfo.value!.price!),
                      ],
                    ),
                  ),
                ),
              ));

      kTicketDetailInfoLoading(Status.success);
    } catch (e) {
      print(e);

      kTicketDetailInfoLoading(Status.error);
    }
  }

  Future<void> buyExtraTicket(
    BuildContext context, {
    required String price,
    required String quantity,
  }) async {
    try {
      Map<String, dynamic> data = {"price": price, "quantity": quantity};
      kButExtraTicketsLoading(Status.loading);
      final res = await CouponCardRepo.buyExtraTicket(data);
      Navigator.pop(context);
      kButExtraTicketsLoading(Status.success);
      fGetLuckyCard();
      showCustomSnackBar(context, res.response["message"]);
    } catch (e) {
      kButExtraTicketsLoading(Status.error);
    }
  }

  Future<void> buyDisscountCard(
    BuildContext context, {
    required String discountId,
    required String price,
    required String deliveryFee,
  }) async {
    try {
      Map<String, dynamic> data = {
        "discountCard": discountId,
        "price": price,
        "deliveryFee": deliveryFee
      };
      kbuyDiscountCardLoading(Status.loading);
      final res = await CouponCardRepo.buyDisscountCard(data);

      showCustomSnackBar(context, res.response["message"]);

      Get.offAll(() => NavigationScreen());
      Get.find<LandingController>().kCurrentScreenIndex(1);
      // Future.delayed(Duration(milliseconds: ), () {

      // });
      kbuyDiscountCardLoading(Status.success);
    } catch (e) {
      kbuyDiscountCardLoading(Status.error);
    }
  }

  Future<void> checkActiveDiscountCard(
    BuildContext context, {
    String? fromScreen,
  }) async {
    try {
      kCheckActiveLoading(Status.loading);
      final response = await CouponCardRepo.checkActiveDiscountCard();

      final bool isActive = response.response["isActive"];
      final String message = response.response["message"];
      // showCustomSnackBar(context, message);
      if (isActive) {
        showCustomSnackBar(context, "You already have an active discount card");
        if (fromScreen == "productDetails") {
          Navigator.pop(context);
        } else {
          return;
        }
      } else {
        Get.off(OrderSummaryScreen(
          discountInfoModel: kDiscountInfoList.first,
        ));
      }

      kCheckActiveLoading(Status.success);
      return;
    } catch (e) {
      kCheckActiveLoading(Status.error);

      rethrow;
    }
  }

  Future<bool> checkDiscountCardFromProductBuy(BuildContext context) async {
    try {
      kCheckActiveLoading(Status.loading);
      final response = await CouponCardRepo.checkActiveDiscountCard();

      final bool isActive = response.response["isActive"];
      final String message = response.response["message"];
      if (!isActive) {
        showCustomSnackBar(context, message);
      }

      kCheckActiveLoading(Status.success);
      return isActive;
    } catch (e) {
      kCheckActiveLoading(Status.error);
      rethrow;
    }
  }

  Future<void> fGetDiscountCardsList() async {
    try {
      kDiscountCardLoading(Status.loading);
      final res = await CouponCardRepo.fGetListOfDiscountCards(
        cardStatus: discountCardFilters.value,
      );
      kDiscountCardsList.clear();
      kDiscountCardsList.addAll(res);
      kDiscountCardLoading(Status.success);
    } catch (e) {
      kDiscountCardLoading(Status.error);
    }
  }

  Row buildCartAndGoToCartButtonWidget(BuildContext context, String price) {
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
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        if (quantity.value > 1) quantity.value--;
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppPalette.white,
                        size: 20,
                      ),
                    ),
                    Text(
                      "${quantity.value}",
                      style: TypoWhite.white50015,
                    ),
                    InkWell(
                      onTap: () {
                        quantity.value++;
                      },
                      child: Icon(
                        Icons.add,
                        color: AppPalette.white,
                        size: 20,
                      ),
                    ),
                  ],
                )),
          ),
        ),
        CMaterialButton(
          height: 40,
          minWidth: 140,
          color: AppPalette.darkViolet,
          child: Text(
            "Buy now ${ConstantText.rupeeSymbol}${price}",
            style: TypoWhite.white50015,
          ),
          onPressed: () {
            buyExtraTicket(price: price, quantity: "$quantity", context);
            // Trigger buyDisscountCard here if needed
          },
        ),
      ],
    );
  }
}
