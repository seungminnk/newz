import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/application/user/controller/user_data_controller.dart';
import 'package:newz/feature/onboarding/controller/keyword_list_controller.dart';

class OnboardingResultView extends StatelessWidget {
  const OnboardingResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserDataController());

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.33,
            child: Container(
              color: const Color(0xFF263238),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 56,
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Column(
                children: const [
                  Text(
                    "흥미로운 키워드에요",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "키워드를 토대로",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "기사를 요약해드릴게요!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Expanded(
                child: Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: [
                            for (var keyword
                                in KeywordListController.to.enteredKeywords)
                              _generateEnteredKeywordTag(keyword),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Container(
                  color: KeywordListController.to.enteredKeywords.isEmpty
                      ? const Color(0xFFC5CAE9)
                      : const Color(0xFF3F51B5),
                  child: TextButton(
                    onPressed: KeywordListController.to.enteredKeywords.isEmpty
                        ? null
                        : _onClickLetsStartBtn,
                    child: const Text(
                      '이제 시작해볼까요?',
                      style: TextStyle(
                        fontSize: 16,
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
    );
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
        color: const Color(0xFF3F51B5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        keyword,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }

  _onClickLetsStartBtn() async {

    // FIXME 추후 api 변경될 것임 그전까지 디버그 용도로 사용, 삭제 예정된 코드
    UserDataController.to.didSelectKeywords(true);
    Get.offAllNamed(AppRoutes.application);

    // FIXME 원래 로직으로써 나중에 살려야 할 부분이다.
    // final dio = Dio();
    //
    // String requestUrl = "https://newz.bbear.kr/api/user/keyword";
    // final response = await dio.post(requestUrl, data: {
    //   'userId': UserDataController.to.id.value,
    //   'keywords': KeywordListController.to.enteredKeywords.toList()
    // });
    //
    // if (response.statusCode == 200) {
    //   // onboarding complete flag true로 변경하기
    //   UserDataController.to.didSelectKeywords(true);
    // } else {
    //   // 에러 리턴
    // }
    //
    // if (UserDataController.to.didSelectKeywords.value) {
    //   Get.offAllNamed(AppRoutes.application);
    // }

  }
}
