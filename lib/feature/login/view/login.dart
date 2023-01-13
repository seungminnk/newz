import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/feature/login/controller/login_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => loginController.isLogin.isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(loginController.userData.photoUrl!),
                    Text(loginController.userData.displayName!),
                    Text(loginController.userData.email),
                    MaterialButton(
                      onPressed: loginController.logout,
                      height: 50,
                      minWidth: 100,
                      color: Colors.red,
                      child: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: MaterialButton(
                  onPressed: (() {
                    loginController.login();
                  }),
                  height: 50,
                  minWidth: 100,
                  color: Colors.red,
                  child: const Text(
                    'Google Signin',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
      ),
    );
  }
}
