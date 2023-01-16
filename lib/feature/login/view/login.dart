import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/login/controller/login_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Get.back();
          }),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(
        () => Center(
          //loginController.login();
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset('assets/images/title.svg'),
            const SizedBox(height: 50),
            Image.asset('assets/images/IMAGE.png'),
            const SizedBox(height: 60),
            const Text('SNS 계정으로 간편하게 가입하기'),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                loginController.login();
              },
              icon: Image.asset('assets/icons/googleIcon.png'),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                loginErrorDialog(context);
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('로그인에 어려움이 있나요?')),
            ),
            const SizedBox(height: 10),
            loginController.isLogin.isTrue
                ? GestureDetector(
                    onTap: () {
                      loginController.logout();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.transparent,
                      ),
                      child: const Text('로그아웃'),
                    ),
                  )
                : const SizedBox(height: 1),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> loginErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              height: Get.height / 7,
              width: Get.width / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "계정 접속에 이상이 있어요",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "다시 시도해 주세요.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            actionsPadding: const EdgeInsets.only(bottom: 20),
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(70, 15, 70, 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF3F51B5),
                    ),
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
