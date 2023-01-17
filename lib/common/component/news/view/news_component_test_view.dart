import 'package:flutter/material.dart';
import 'package:newz/common/component/news/view/news_summary_component_view.dart';

class NewsComponentTestView extends StatelessWidget {
  const NewsComponentTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('뉴스 컴포넌트 테스트')),
      body: Center(
        child: Placeholder(),
      )
    );
  }
}
