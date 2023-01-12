import 'package:flutter/material.dart';
import 'package:newz/feature/application/view/application_view.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/home/view/home_view.dart';
import 'package:newz/feature/mypage/view/mypage_view.dart';
import 'package:newz/feature/search/view/search_view.dart';

class AppRoutesInfo {
  static Map<String, WidgetBuilder> details = {
    // AppRoutes.splash : (context) => const ApplicationView(),
    AppRoutes.application: (context) => const ApplicationView(),

    AppRoutes.home: (context) => const HomeView(),
    AppRoutes.search: (context) => const SearchView(),
    AppRoutes.mypage: (context) => MyPageView(),
  };
}
