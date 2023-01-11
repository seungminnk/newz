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

    final dio = Dio();
    final response = await dio.get("http://localhost:3001/api/user/?id=1");

    var userData = User.fromJson(response.data);

    id = RxInt(userData.id);
    loginType = RxString(userData.loginType);
    name = RxString(userData.name);
    email = RxString(userData.email);
    didSelectKeywords = RxBool(userData.completeOnboarding);
  }

  void setDidSelectedKeywordsFlag(bool flag) {
    didSelectKeywords = flag as RxBool;
  }
}
