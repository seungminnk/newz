import 'package:flutter/material.dart';
import 'package:newz/feature/application/application_view.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/home/home_view.dart';
import 'package:newz/feature/mypage/mypage_view.dart';
import 'package:newz/feature/search/search_view.dart';

class AppRoutesInfo{
  static Map<String, WidgetBuilder> details = {
    // AppRoutes.splash : (context) => const ApplicationView(),
    AppRoutes.application : (context) => const ApplicationView(),

    AppRoutes.home : (context) => const HomeView(),
    AppRoutes.search : (context) => const SearchView(),
    AppRoutes.mypage : (context) => const MyPageView(),
  };
}