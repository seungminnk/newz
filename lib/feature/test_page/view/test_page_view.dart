import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/view/keyword_radio_group_button_test_view.dart';
import 'package:newz/common/component/news/view/news_component_test_view.dart';
import 'package:newz/common/component/news/view/news_component_view.dart';
import 'package:newz/feature/ads/view/ads_test_view.dart';
import 'package:newz/feature/real_time_vogue/view/real_time_vogue_view.dart';

class TestPageView extends StatelessWidget {
  const TestPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('테스트를 위한 페이지 입니다.'),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _testPageNavigateButton(context, "Native 광고 페이지", (context) => const AdsTestView()),
            _testPageNavigateButton(context, "인기 페이지", (context) => const RealTimeVogueView()),
            _testPageNavigateButton(context, "뉴스 공통 컴포넌트", (context) => const NewsComponentTestView()),
            _testPageNavigateButton(context, "키워드 공통 컴포넌트", (context) => const KeywordRadioGroupButtonTestView()),
          ],
        ),
      ),
    );
  }

  Widget _testPageNavigateButton(BuildContext context, String buttonText, WidgetBuilder testPageBuilder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: testPageBuilder),
            );
          },
          child: Text(buttonText),
        ),
      ),
    );
  }
}
