import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/config/routes/app_routes.dart';
import 'package:newz/config/user/controller/user_data_controller.dart';
import 'package:newz/config/user/model/token.dart';
import 'package:newz/config/user/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late GoogleSignInAccount userData;

  late final GoogleSignInAuthentication googleSignInAuthentication;

  final UserDataController userDataController = Get.find();

  final dio = Dio();

  RxString userName = "".obs;
  RxString userEmail = "".obs;

  // 토큰 갱신
  static void refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString("refreshToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-refresh-token': refreshToken};
    try {
      final response = await dio.post("/user/token/reissue");
      var user = Token.fromJson(response.data);
      prefs.setString("accessToken", user.accessToken);
      prefs.setString("refreshToken", user.refreshToken);
    } catch (e) {
      print(e);
    }
  }

  void loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName(prefs.getString("userName"));
    userEmail(prefs.getString("userEmail"));
    isLogin(prefs.getBool("isLogin"));
  }

  void logout() async {
    print("로그아웃 실행");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", false);
    _googleSignIn.signOut().then((value) async {
      userDataController.removeUserData();
      userName("");
      userEmail("");
      isLogin(false);
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  void login() async {
    print("로그인 실행");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogin", true);
    _googleSignIn.signIn().then<void>((value) async {
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
