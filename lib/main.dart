import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/routes/app_routes_info.dart';
import 'package:newz/feature/application/controller/application_controller.dart';

void main() {
  controllerInit();
  runApp(const MyApp());
}

void controllerInit(){
  Get.lazyPut(() => ApplicationController());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'newz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.application,
      routes: AppRoutesInfo.details,
    );
  }
}