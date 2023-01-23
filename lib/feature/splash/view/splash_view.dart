import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newz/config/routes/app_routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    /**
     * 설명
     * - SystemChrome.setEnabledSystemUIMode : 상단바, 하단바 사용 여부 제어
     * - SystemChrome.setSystemUIOverlayStyle : 상단바 스타일 제어
     *
     * */
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.offAllNamed(AppRoutes.application,);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // fit: StackFit.,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            "assets/images/splash/splash_background.png",
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 90),
              child: Image.asset("assets/images/splash/splash_logo.png"),
            ),
          ),
        ],
      ),
    );
  }
}
