import 'package:get/get.dart';

class IntroductionController extends GetxController {
  static IntroductionController get to => Get.find<IntroductionController>();

  RxInt carouselIndex = 0.obs;

  void changeCarouselIndex(int index) {
    carouselIndex.value = index;
  }
}
