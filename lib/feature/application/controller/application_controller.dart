import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ApplicationController extends GetxController{

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
    await _initGoogleMobileAds();
    super.onInit();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  void dispose() {
    super.dispose();
  }
}