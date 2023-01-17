import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ApplicationController extends GetxController{

  static Future<ApplicationController> init() async {
    if(!kIsWeb) {
      await MobileAds.instance.initialize();
    }
    final controller = ApplicationController();
    return controller;
  }

  RxInt bottomNavigationBarIndex = 0.obs;

  PageController applicationPageController = PageController();

  void bottomNavigationBarOnTap(int barIndex){
    bottomNavigationBarIndex.value = barIndex;
    applicationPageController.jumpToPage(barIndex);
  }

  void pageChanged(int pageIndex){
    bottomNavigationBarIndex.value = pageIndex;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}