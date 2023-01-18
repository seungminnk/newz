import 'package:flutter/material.dart';
import 'package:newz/feature/application/view/application_view.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/home/view/home_view.dart';
import 'package:newz/feature/login/view/login.dart';
import 'package:newz/feature/mypage/view/mypage_view.dart';
import 'package:newz/feature/onboarding/view/introduction_final_view.dart';
import 'package:newz/feature/onboarding/view/introduction_view.dart';
import 'package:newz/feature/onboarding/view/keyword_result_view.dart';
import 'package:newz/feature/onboarding/view/keyword_view.dart';
import 'package:newz/feature/search/view/search_view.dart';
import 'package:newz/feature/splash/view/splash_view.dart';

class AppRoutesInfo {
  static Map<String, WidgetBuilder> details = {
    AppRoutes.splash : (context) => const SplashView(),
    AppRoutes.application: (context) => const ApplicationView(),

    AppRoutes.home: (context) => const HomeView(),
    AppRoutes.search: (context) => const SearchView(),
    AppRoutes.mypage: (context) => const MyPageView(),
    AppRoutes.keyword: (context) => const KeywordView(),
    AppRoutes.keywordResult: (context) => const KeywordResultView(),
    AppRoutes.login: (context) => Login(),
    AppRoutes.introduction: (context) => const IntroductionView(),
    AppRoutes.introductionFinal: (context) => const IntroductionFinalView(),
  };
}
