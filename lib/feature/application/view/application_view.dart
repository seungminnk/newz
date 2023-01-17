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

  @override
  Widget build(BuildContext context) {
    // Get.put(ApplicationController());

    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );

    // return Obx(() => Scaffold(
    //       body: UserDataController.to.didSelectKeywords.value
    //           ? _buildPageView()
    //           : const IntroductionView(),
    //       bottomNavigationBar: UserDataController.to.didSelectKeywords.value
    //           ? _buildBottomNavigationBar(controller)
    //           : null,
    //     ));
  }

  PageView _buildPageView() {
    return PageView(
      controller: controller.applicationPageController,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: controller.pageChanged,
      children: const [
        HomeView(),
        SearchView(),
        MyPageView(),
        TestPageView(),
      ],
    );
  }

  // FIXME 함수형 위젯 사용 지양
  // FIXME 네비게이션바 아이콘, 디자인 수정 필요
  Widget _buildBottomNavigationBar(ApplicationController controller) {
    return SizedBox(
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
              icon: SvgPicture.asset("assets/icons/home.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/home.svg",
                color: Colors.lightBlue,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset("assets/icons/search.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.lightBlue,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: SvgPicture.asset("assets/icons/user.svg"),
              activeIcon: SvgPicture.asset(
                "assets/icons/user.svg",
                color: Colors.lightBlue,
              ),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: SizedBox(
                width: 23,
                height: 23,
                child: SvgPicture.asset("assets/icons/experiment.svg"),
              ),
              activeIcon: SizedBox(
                  width: 23,
                  height: 23,
                  child: SvgPicture.asset(
                    "assets/icons/experiment.svg",
                    color: Colors.lightBlue,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
