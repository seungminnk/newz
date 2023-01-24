import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newz/config/routes/app_routes.dart';
import 'package:newz/config/user/controller/user_data_controller.dart';
import 'package:newz/config/user/model/user.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late GoogleSignInAccount userData;

  late final GoogleSignInAuthentication googleSignInAuthentication;

  final dio = Dio();

  void logout() {
    _googleSignIn.signOut().then((value) {
      isLogin(false);
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  void login() {
    _googleSignIn.signIn().then<void>((value) async {
      isLogin(true);
      userData = value!;

      final response = await dio.post("http://localhost:3001/api/user/login",
          data: {
            "serviceUniqueId": googleSignInAuthentication.idToken,
            "serviceType": "google"
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
