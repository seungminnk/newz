import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserDataController extends GetxController {
  static UserDataController get to => Get.find<UserDataController>();

  RxInt id = 0.obs;
  RxString loginType = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;

  RxBool didSelectInitialKeywords = false.obs;

  Future<void> setUserData(User userData) async {
    id.value = userData.id;
    name.value = userData.name;
    email.value = userData.email;
    didSelectInitialKeywords.value = !userData.haveKeywords;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("accessToken", userData.tokens.accessToken);
    prefs.setString("refreshToken", userData.tokens.refreshToken);
    prefs.setInt("userId", userData.id);
    prefs.setString("userName", userData.name);
    prefs.setString("userEmail", userData.email);
  }

  Future<void> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void setDidSelectedInitialKeywordsFlag(bool flag) {
    didSelectInitialKeywords.value = flag;
  }
}
