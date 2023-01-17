import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class UserDataController extends GetxController {
  static UserDataController get to => Get.find<UserDataController>();

  RxInt id = 0.obs;
  RxString loginType = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;

  RxBool didSelectKeywords = false.obs;

  @override
  void onInit() async {
    super.onInit();

    // FIXME dio는 한군데에서 선언해서 사용하거나, 설정을 공유 할 수 있도록 만들어주세요.
    final dio = Dio();
    final response =await dio.get("https://newz.bbear.kr/api/user?userId=1");

    var userData = User.fromJson(response.data);

    id.value = userData.id;
    loginType.value = userData.loginType;
    name.value = userData.name;
    email.value = userData.email;
    didSelectKeywords.value = userData.completeOnboarding;
  }

  void setDidSelectedKeywordsFlag(bool flag) {
    didSelectKeywords.value = flag;
  }
}
