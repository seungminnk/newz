import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/routes/app_routes_info.dart';
import 'package:newz/feature/application/controller/application_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_controller.dart';

void main() {
  _controllerInit();
  runApp(const MyApp());
}

void _controllerInit() {
  Get.lazyPut(() => ApplicationController());

  Get.lazyPut(() => RealTimeVogueController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
