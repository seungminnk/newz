import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/login/controller/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});
  final LoginController loginController = Get.find();
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
        centerTitle: true,
        title: const Text(
          '설정',
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            color: Color(0xff37474f),
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Center(
              child: GestureDetector(
                onTap: _sendEmail,
                child: const Text(
                  '문의하기',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    color: Color(0xff37474f),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 314),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "ID: ${loginController.userData.id}",
              style: const TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20,
                color: Color(0xff37474f),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "연결된 계정",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: Color(0xff37474f),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  loginController.isLogin.isTrue ? "Google" : "연결된 계정 없음",
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    color: Color(0xff3F51B5),
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    "assets/icons/settingLine.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/settingPage_setting.svg",
                ),
                const SizedBox(width: 16),
                const Text(
                  "관심분야 설정",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 16,
                    color: Color(0xff37474F),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/check.svg",
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      "버전",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 16,
                        color: Color(0xff37474F),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "최신버전입니다.",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 12,
                    color: Color(0xffB0BEC5),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                loginController.logout();
              },
              child: const Text(
                "로그아웃",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  fontSize: 16,
                  color: Color(0xff37474F),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _sendEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: "newmoa.newz@gmail.com",
  );
  launchUrl(emailLaunchUri);
}
