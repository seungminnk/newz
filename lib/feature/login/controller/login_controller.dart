import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  RxBool isLogin = false.obs;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late GoogleSignInAccount userData;

  late final GoogleSignInAuthentication googleSignInAuthentication;

  void logout() {
    _googleSignIn.signOut().then((value) {
      isLogin(false);
    }).catchError((e) {
      // ignore: avoid_print
      print(e);
    });
  }

  void login() {
    _googleSignIn.signIn().then<void>((value) {
      isLogin(true);
      userData = value!;
      Get.back();
      print(googleSignInAuthentication.idToken);
      print(googleSignInAuthentication.accessToken);
    }).catchError((e) {
      print(e);
    });
    // print(userToken);
  }
}
