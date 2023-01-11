import 'package:get/get.dart';

class ScrapController extends GetxController {
  RxBool isLiked = false.obs;

  void scrapButtonClick() {
    if (isLiked.isFalse) {
      isLiked(true);
    } else {
      isLiked(false);
    }
  }
}
