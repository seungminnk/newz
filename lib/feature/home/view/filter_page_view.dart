import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/onboarding/controller/keyword_list_controller.dart';
import 'package:newz/feature/onboarding/controller/keyword_editing_controller.dart';
import '../../../common/component/loading/view/CustomCircularProgressIndicator.dart';
import '../../mypage/controller/mypage_controller.dart';
import '../../mypage/service/mypage_api_service.dart';

class FilterPageView extends StatefulWidget {
  const FilterPageView({Key? key}) : super(key: key);
  @override
  State<FilterPageView> createState() => _FilterPageViewState();
}

class _FilterPageViewState extends State<FilterPageView> {
  final keywordListController = Get.put(KeywordListController());
  final keywordEditingController = Get.put(KeywordEditingController());
  final mypageController = Get.put(Mypagecontroller());
  final _searchController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;
  void _unFocus() {
    _focusNode.unfocus();
    _searchController.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x6637474F),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 24),
        Center(
          child: Column(
            children: const [
              Text(
                "키워드 선택",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "다른 흥미로운",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "키워드를 선택해보세요",
                style: TextStyle(
                  fontFamily: 'Pretendard',
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _searchController,
                  onSubmitted: (String keyword) {
                    ApiService.addKeyword(keyword);
                    mypageController.fetchKeyword();
                    _searchController.clear();
                  },
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xffffffff),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Container(
                      width: 24,
                      height: 24,
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        color: const Color(0xffffffff),
                      ),
                    ),
                    hintText: '원하는 키워드를 적어보아요',
                    hintStyle: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                    suffixIcon: GestureDetector(
                      onTap: _unFocus,
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Obx(
            () => mypageController.isKeywordLoading.isFalse
                ? const CustomCircularProgressIndicator()
                : SizedBox(
                    width: Get.width,
                    height: 35,
                    child: ListView.separated(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      itemCount: mypageController.keywordlist.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 10);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: const Color(0xffffffff),
                          ),
                          child: Obx(
                            () => Center(
                              child: Row(
                                      children: [
                                        Text(mypageController.keywordlist[index],
                                            style: const TextStyle(
                                                color: Color(0xff37474f))),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                            onTap: () {
                                              mypageController.keywordRemoveBtn(
                                                  mypageController
                                                      .keywordlist[index]);
                                              mypageController.fetchKeyword();
                                            },
                                            child: const Icon(
                                              Icons.cancel_outlined,
                                              size: 18,
                                              color: Color(0xff37474f),
                                            )),
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ),
      ]),
    );
  }
}
