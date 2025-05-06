import 'package:dyd/feature/product/controller/product_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'core/data/response/api_call_type_response.dart';
import 'feature/lucky-card/controller/discount_card_controller.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void init() {
    getIt.registerSingleton<ApiCallType>(ApiCallType()); //api call
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CouponCardController());
  }
}
