import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}