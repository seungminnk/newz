import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:newz/config/routes/app_routes.dart';

class IntroductionFinalView extends StatelessWidget {
  const IntroductionFinalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    const standardDeviceWidth = 360;

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.33,
            child: Container(
              color: const Color(0xFF303F9F),
            ),
          ),
          Column(
            children: [
              Container(
                height: 56,
              ),
              const SizedBox(height: 20),
              const Text(
                "수많은 뉴스 기사를 한번에",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "NEWZ에 오신 걸 환영해요!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // FIXME 이전 화면과 마찬가지로, 화면이 넓은 기기에서는 허전하지 않은지 디자이너님과 논의가 필요합니다.
              Expanded(
                child: SizedBox(
                  width: 200 * (deviceWidth / standardDeviceWidth),
                  child: const Image(
                    image: AssetImage('assets/images/intro_4.png'),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color(0xFF3F51B5)),
                child: TextButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool("didOnboarding", true);

                    Get.toNamed(AppRoutes.login);
                  },
                  child: const Text(
                    "NEWZ 시작하기",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ],
      ),
    );
  }
}
