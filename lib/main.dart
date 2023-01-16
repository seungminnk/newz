// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/routes/app_routes_info.dart';
import 'package:newz/application/user/controller/user_data_controller.dart';
import 'package:newz/feature/application/controller/application_controller.dart';
import 'package:newz/feature/onboarding/controller/keyword_list_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_keyword_controller.dart';

void main() {
  _controllerInit();
  runApp(const MyApp());
}

void _controllerInit() {
  Get.lazyPut(() => ApplicationController());

  Get.lazyPut(() => RealTimeVogueController());
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
