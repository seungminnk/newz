import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newz/feature/home/components/keyword_box.dart';
import 'package:newz/feature/home/controller/home_controller.dart';
import 'package:newz/feature/home/view/filter_page_view.dart';
import 'package:newz/feature/onboarding/controller/keyword_list_controller.dart';
import '../../../common/component/keyword/model/keyword_radio_model.dart';
import '../../../common/component/keyword/view/custom_keyword_button_group_view.dart';
import '../../../common/component/loading/view/CustomCircularProgressIndicator.dart';
import '../../../common/component/news/view/news_component_view.dart';
import '../../login/controller/login_controller.dart';
import 'package:newz/feature/search/model/dto/search_response_only_data_dto.dart' as SearchNewsData;


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final List keyword = [];
  // final List<String> title = <String>['title', 'title'];
  // final List<String> content = <String>['content', 'content'];
  final loginController = Get.put(LoginController());
  // final keywordListController = Get.put(KeywordListController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (homeController) {
          return Scaffold(
            appBar: AppBar(
              title: Container(
                child:
                SvgPicture.asset("assets/icons/logo.svg",
                  width: 88,
                  height: 40,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: [
                IconButton(icon: SvgPicture.asset("assets/icons/mypage_setting.svg"),
                  onPressed: () =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FilterPageView())),)
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: loginController.isLogin.isFalse
                      ? const Text(
                    '길동 님의 관련 기사를 가져왔어요!',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20,
                      color: Color(0xff37474f),
                      fontWeight: FontWeight.w600,

                    ),
                  )
                      : Text(
                    '${loginController.userData.displayName!} 님의 관련 기사를 가져왔어요!',
                    style: const TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: 20,
                      color: Color(0xff37474f),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 18,),
                SizedBox(height: 35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController.keywordList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: KeywordBox(
                            keyword: homeController.keywordList[index],
                            position: index,
                          ),
                        );
                      }
                  ),
                ),
                // Column(
                //   children: [
                //     Expanded(child:
                //     ListView.builder(
                //       scrollDirection: Axis.vertical,
                //       padding: EdgeInsets.all(8),
                //       itemCount: title.length,
                //       itemBuilder: (context, index) {
                //         List<KeywordRadioModel> keywordRadioModelList = KeywordRadioModel.getKeywordListByDio(keyWordInstances)
                //         return Container(
                //           width: MediaQuery
                //               .of(context)
                //               .size
                //               .width,
                //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //           child: CustomKeywordButtonGroupView(
                //             keywordRadioModelList: keywordRadioModelList,
                //             isHorizontalListView: true,
                //             isFirstButtonClickStateOn: true,
                //             clickCb: (KeywordRadioModel clickedValue) {
                //               for (var keyword
                //               in KeywordListController.to.fixedKeywords)
                //                 _generateEnteredKeywordTag(keyword);
                //             },
                //           ),
                //         );
                //       },
                //     ),
                //     ),
                //     PagedListView<int, SearchNewsData.News>(
                //       physics: const BouncingScrollPhysics(),
                //       pagingController: controller.pagingController,
                //       builderDelegate: PagedChildBuilderDelegate<SearchNewsData.News>(
                //           itemBuilder: (context, item, index) {
                //             if (index == 0) {
                //               return Padding(
                //                 padding: const EdgeInsets.fromLTRB(
                //                     20.0, 22.0, 20.0, 8.0),
                //                 child: NewsComponentView(
                //                   title: item.title,
                //                   content: item.content,
                //                   link: item.link,
                //                   key: Key(index.toString()),
                //                 ),
                //               );
                //             }
                //
                //             return Padding(
                //               padding: const EdgeInsets.fromLTRB(
                //                   20.0, 8.0, 20.0, 8.0),
                //               child: NewsComponentView(
                //                 title: item.title,
                //                 content: item.content,
                //                 link: item.link,
                //                 key: Key(index.toString()),
                //               ),
                //             );
                //           },
                //           firstPageProgressIndicatorBuilder: (context) {
                //             return const Center(
                //               child: CustomCircularProgressIndicator(),
                //             );
                //           },
                //           newPageProgressIndicatorBuilder: (context) {
                //             return const Padding(
                //               padding: EdgeInsets.all(8.0),
                //               child: Center(
                //                 child: CustomCircularProgressIndicator(),
                //               ),
                //             );
                //           }
                //       ),
                //     ),
                //
                //   ],
                // )
              ],
            ),
          );
        }
    );
  }
}

Widget _generateEnteredKeywordTag(String keyword) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      top: 10,
      bottom: 10,
    ),
    // padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: Color(0xff37474f)
        )
    ),
    child: Text(
      keyword,
      style: const TextStyle(
        fontFamily: 'Pretendard',
        fontSize: 12,
        color: Color(0xff37474f),
      ),
    ),
  );
}

