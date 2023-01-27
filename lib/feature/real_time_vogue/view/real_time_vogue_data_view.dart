import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/common/component/news/view/news_component_view.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

class RealTimeVogueDataView extends GetView<RealTimeVogueDataController> {
  const RealTimeVogueDataView({super.key});

  final Color fontColor = const Color.fromARGB(255, 55, 71, 79);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        News responseNews = controller.vogueNewsList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: NewsComponentView(
            title: responseNews.title,
            content: responseNews.content,
            link: responseNews.link,
          ),
        );
      },
      itemCount: controller.vogueNewsList.length,
    );
  }
}
