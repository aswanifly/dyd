import 'package:get/get.dart';

class LandingController extends GetxController {
  RxInt kCurrentScreenIndex = 0.obs;

  void fChangeCurrentScreenIndex(int value) {
    kCurrentScreenIndex(value);
  }
}
