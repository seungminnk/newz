import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/feature/home/components/keyword_box.dart';
import 'package:newz/feature/home/controller/home_controller.dart';
import 'package:newz/feature/home/view/filter_page_view.dart';
import 'package:newz/feature/search/controller/search_result_controller.dart';
import 'package:newz/feature/search/view/search_news_view.dart';

import '../../login/controller/login_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final loginController = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());
  final SearchResultController searchResultController = Get.put(SearchResultController(), tag: 'home');

  @override
  void initState() {
    super.initState();
    searchResultController.searchPageModel.searchKeyword.value =
        homeController.keywordList[0];
    homeController.addListener(pageChangeEvent);
    loginController.loadUserData();
  }

  @override
  void dispose() {
    homeController.removeListener(pageChangeEvent);
    super.dispose();
  }

  void pageChangeEvent() {
    searchResultController.searchPageModel.searchKeyword.value =
        homeController.keywordList[homeController.selectedKeywordIndex];
  }

  @override
  Widget build(BuildContext context) {
    homeController.load();
    return GetBuilder(
      builder: (HomeController homeController) {
        return Scaffold(
          appBar: AppBar(
            title: SvgPicture.asset(
              "assets/icons/logo.svg",
              width: 88,
              height: 40,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            // FIXME 현재는 기능이 동작하지 않음으로 숨김 처리해 두었다.
            // actions: [
            //   IconButton(
            //     icon: SvgPicture.asset("assets/icons/mypage_setting.svg"),
            //     onPressed: () => Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const FilterPageView())),
            //   )
            // ],
          ),
          body:
          !homeController.loaded ? const Center(child: CustomCircularProgressIndicator()) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Obx(
                  () => Text(
                    '${loginController.userName}님의 관련 기사를 가져왔어요!',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20,
                      color: Color(0xff37474f),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: 35,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: homeController.keywordList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          // TODO 선택 키워드 스타일 지정
                          child: KeywordBox(
                            keyword: homeController.keywordList[index],
                            position: index,
                            selected: index == homeController.selectedKeywordIndex,
                          ),
                        ),
                        onTap: () {
                          homeController.changeIndex(index);
                        },
                      );
                    }),
              ),
              const Expanded(
                child: SearchNewsView(
                  tag: 'home',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
