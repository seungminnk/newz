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
            SvgPicture.asset('assets/images/logo.svg'),
            const SizedBox(height: 50),
            Image.asset('assets/images/IMAGE.png'),
            const SizedBox(height: 60),
            const Text(
              'SNS 계정으로 간편하게 가입하기',
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 12,
                color: Color(0xff37474f),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              onPressed: () {
                loginController.login();
              },
              icon: SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.asset(
                    'assets/icons/googleIcon.png',
                    fit: BoxFit.fill,
                  )),
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
                    border:
                        Border.all(width: 1, color: const Color(0xFFCFD8DC)),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '로그인에 어려움이 있나요?',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 12,
                      color: Color(0xff37474f),
                      fontWeight: FontWeight.w400,
                    ),
                  )),
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SizedBox(
              height: 200,
              width: 312,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          icon: SvgPicture.asset('assets/icons/cancel.svg'),
                        )
                      ],
                    ),
                    const Text(
                      "계정 접속에 이상이 있어요",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Text(
                      "다시 시도해 주세요.",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 160,
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF3F51B5),
                        ),
                        child: const Center(
                          child: Text(
                            '취소',
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '문의하기',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 14,
                        color: Color(0xffB0BEC5),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
