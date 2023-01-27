import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
    );
  }
}
