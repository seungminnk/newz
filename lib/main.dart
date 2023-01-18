// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/routes/app_routes_info.dart';
import 'package:newz/application/user/controller/user_data_controller.dart';
import 'package:newz/feature/application/controller/application_controller.dart';
import 'package:newz/feature/onboarding/controller/keyword_list_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_keyword_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // async main 사용을 위한 코드
  await _controllerInit();
  runApp(const MyApp());
}

Future _controllerInit() async {
  // Get.put은 코드가 실행되는 시점에 생성됩니다.

  // Get.lazyPut은 Get.find()를 통해 호출되는 시점에 생성됩니다.

  // Get.puyAsync는 코드가 실행되는 시점에 Future를 기다립니다.
  // GetxController가 초기화 되고 나서 앱이 실행되어야하거나,
  // 의존성으로 초기화 순서가 명확해야할때 사용할 수 있습니다.
  await Get.putAsync(() => ApplicationController.init());

  Get.lazyPut(() => RealTimeVogueDataController());
  Get.lazyPut(() => RealTimeVogueKeywordController());

  Get.lazyPut(() => UserDataController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'newz',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.application,
      routes: AppRoutesInfo.details,
    );
  }
}
