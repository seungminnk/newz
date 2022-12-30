import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/routes/app_routes_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   home: SafeArea(
    //     child: GetMaterialApp(
    //       title: 'newz',
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       initialRoute: AppRoutes.application,
    //       routes: AppRoutesInfo.details,
    //     ),
    //   ),
    // );
    return GetMaterialApp(
      title: 'newz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.application,
      routes: AppRoutesInfo.details,
    );
  }
}