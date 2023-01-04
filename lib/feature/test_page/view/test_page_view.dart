import 'package:flutter/material.dart';
import 'package:newz/feature/ads/view/ads_test_view.dart';

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
            _adTestButton(context),
          ],
        ),
      ),
    );
  }

  Widget _adTestButton(BuildContext context){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>const AdsTestView()),
          );
        },
        child: const Text('Native 광고 테스트'),
      ),
    );
  }
}
