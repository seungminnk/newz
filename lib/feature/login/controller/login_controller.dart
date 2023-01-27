import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/config/routes/app_routes.dart';
import 'package:newz/config/user/controller/user_data_controller.dart';
import 'package:newz/config/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late GoogleSignInAccount userData;

  late final GoogleSignInAuthentication googleSignInAuthentication;

  final UserDataController userDataController = Get.find();

  final dio = Dio();

  void logout() {
    _googleSignIn.signOut().then((value) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", false);
      userDataController.removeUserData();
      isLogin(false);
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  void login() {
    _googleSignIn.signIn().then<void>((value) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isLogin", true);
      isLogin(true);
      userData = value!;

      // GoogleSignInAuthentication googleAuth = await userData.authentication;
      // print("idToken: ${googleAuth.idToken}");
      // print("accessToken: ${googleAuth.accessToken}");

      final response = await DioManager.instance.dio.post("/user/login", data: {
        "serviceUniqueId": userData.id,
        "serviceType": "google",
        "name": userData.displayName,
        "email": userData.email
      });

      var user = User.fromJson(response.data);
      UserDataController.to.setUserData(user);

      if (user.haveKeywords) {
        Get.offAllNamed(AppRoutes.application);
      } else {
        Get.offAllNamed(AppRoutes.keyword);
      }
    }).catchError((e) {
      print(e);
    });
    // print(userToken);
  }
}
