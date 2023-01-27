import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/application/controller/application_controller.dart';
import 'package:newz/feature/home/view/home_view.dart';
import 'package:newz/feature/mypage/view/mypage_view.dart';
import 'package:newz/feature/search/view/search_view.dart';
import 'package:newz/feature/test_page/view/test_page_view.dart';

class ApplicationView extends GetView<ApplicationController> {
  const ApplicationView({Key? key}) : super(key: key);

  final Color notActiveColor = const Color.fromARGB(255, 159, 168, 218);
  final Color activeColor = const Color.fromARGB(255, 48, 63, 159);

  void _onBackPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 18,
                      color: Color(0xff37474f),
                      fontWeight: FontWeight.w400,
                    ),
                    child: Text(
                      '앱을 종료하시겠습니까?',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 4),
                        child: ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 197, 202, 233),
                          ),
                          child: const Text(
                            '확인',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0, right: 24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 63, 81, 181),
                          ),
                          child: const Text(
                            '취소',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // builder: (context) => AlertDialog(
      //   title: const Text("앱을 종료하시겠습니까?"),
      //   actions: <Widget>[
      //     ElevatedButton(
      //       onPressed: () async {
      //         // await player.stop();
      //         SystemNavigator.pop();
      //       },
      //       child: const Text('예'),
      //     ),
      //     ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context, false);
      //       },
      //       child: const Text('아니요'),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBackPressed(context);
        return false;
      },
      child: Scaffold(
        body: PageView(
          controller: controller.applicationPageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: controller.pageChanged,
          children: const [
            HomeView(),
            SearchView(),
            MyPageView(),
            // TestPageView(),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 64,
          child: Obx(
            () => BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 236, 239, 241),
              currentIndex: controller.bottomNavigationBarIndex.value,
              onTap: controller.bottomNavigationBarOnTap,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  label: "",
                  icon: SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: notActiveColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/home.svg",
                    color: activeColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: notActiveColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/search.svg",
                    color: activeColor,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: SvgPicture.asset(
                    "assets/icons/user.svg",
                    color: notActiveColor,
                  ),
                  activeIcon: SvgPicture.asset(
                    "assets/icons/user.svg",
                    color: activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
