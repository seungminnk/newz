// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mypage_controller.dart';

class InfiniteScrollController extends GetxController {
  final bookmarkApi = Get.put(Mypagecontroller());
  var scrollController = ScrollController().obs;

  // 초기 페이지 설정
  RxInt pages = 1.obs;

// 스크롤 이벤트 감지
  @override
  void onInit() {
    loadData();
    scrollController.value.addListener(() {
      if ((scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent) &&
          bookmarkApi.hasData.isTrue) {
        print('스크롤 영역감지');
        print(pages);
        loadData();
      }
    });
    super.onInit();
  }

  // 이벤트 감지에 따른 데이터 호출
  void loadData() {
    bookmarkApi.fetchBookmark(pages.toString());
    pages++;
  }

  // 데이터 호출 초기화
  Future<void> resetData() async {
    bookmarkApi.resetFetchBookmark('1');
    bookmarkApi.fetchKeyword();
    bookmarkApi.changeKeyword(false);
    pages(2);
  }
}
