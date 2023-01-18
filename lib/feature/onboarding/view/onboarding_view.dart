import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:newz/config/routes/app_routes.dart';
import '../controller/keyword_list_controller.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(KeywordListController());

    var textEditingController = TextEditingController();

    return Scaffold(
      body: GetBuilder<KeywordListController>(
        init: KeywordListController(),
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "길동님이 관심있는",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "키워드를 입력해주세요",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "최대 9개까지 입력할 수 있어요",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.only(
                  top: 0,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: TextField(
                  controller: textEditingController,
                  textAlignVertical: TextAlignVertical.center,
                  onSubmitted: (String text) {
                    KeywordListController.to.addKeyword(text);
                    textEditingController.clear();
                  },
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "원하는 키워드를 적어보아요",
                    // prefixIcon: const Icon(Icons.search),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/icons/search.svg",
                        color: const Color(0xFF37474F),
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: GestureDetector(
                        child: SvgPicture.asset(
                          "assets/icons/cancel.svg",
                          color: const Color(0xFF37474F),
                        ),
                        onTap: () => {textEditingController.clear()},
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Obx(
                          () => Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (var keyword
                                  in KeywordListController.to.enteredKeywords)
                                EnteredKeywordTag(enteredKeyword: keyword)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Obx(
                          () => Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              for (var fixedKeyword
                                  in KeywordListController.to.fixedKeywords)
                                FixedKeywordTag(fixedKeyword: fixedKeyword)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => Container(
                    color: KeywordListController.to.enteredKeywords.isEmpty
                        ? const Color(0xFFC5CAE9)
                        : const Color(0xFF3F51B5),
                    child: TextButton(
                      onPressed:
                          KeywordListController.to.enteredKeywords.isEmpty
                              ? null
                              : () => _onTabNextButton(KeywordListController
                                  .to.enteredKeywords
                                  .toList()),
                      child: Text(
                        KeywordListController.to.enteredKeywords.isEmpty
                            ? '확인'
                            : '이제 시작해볼까요?',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _onTabNextButton(List<String> enteredKeyword) {
    Get.toNamed(AppRoutes.onboardingResult);
  }
}

class EnteredKeywordTag extends StatelessWidget {
  final String enteredKeyword;

  const EnteredKeywordTag({super.key, required this.enteredKeyword});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF37474F),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 4,
              top: 9,
              bottom: 9,
            ),
            child: Text(
              enteredKeyword,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              KeywordListController.to.removeKeyword(enteredKeyword);
            },
            icon: const Icon(
              Icons.cancel_outlined,
              size: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class FixedKeywordTag extends StatelessWidget {
  final String fixedKeyword;

  const FixedKeywordTag({super.key, required this.fixedKeyword});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        if (KeywordListController.to.enteredKeywords.length < 9) {
          KeywordListController.to.addKeyword(fixedKeyword);
        }
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 11,
          bottom: 11,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFECEFF1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          fixedKeyword,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF607D8B),
          ),
        ),
      ),
    );
  }
}
