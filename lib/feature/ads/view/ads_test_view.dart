import 'package:flutter/material.dart';
import 'package:newz/feature/ads/view/newz_component_ad_view.dart';

class AdsTestView extends StatefulWidget {
  const AdsTestView({Key? key}) : super(key: key);

  @override
  State<AdsTestView> createState() => _AdsTestViewState();
}

class _AdsTestViewState extends State<AdsTestView> {
  final List<String> list1 = ["1", "2", "3", "4", "5", "6", "7", "8"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Native 광고 테스트")),
      body: ListView.separated(
        // TODO: Adjust itemCount based on the ad load state
        itemCount: list1.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(list1[index])
          );
        },
        separatorBuilder: (context, index){

          if(index != 0 && index % 2 == 0) {
            return const NewzComponentAdView();
          }
          else{
            return const SizedBox(height: 0);
          }

        },
      ),
    );
  }
}
