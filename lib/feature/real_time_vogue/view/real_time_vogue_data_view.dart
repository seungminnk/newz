import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/mypage/view/webview_page.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

class RealTimeVogueDataView extends GetView<RealTimeVogueDataController> {
  const RealTimeVogueDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.vogueResponseOnlyData == null ?
        const SizedBox(width: 0)
        :
        ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index){

            News responseNews = controller.vogueResponseOnlyData!.news![index];

            // return Text(responseNews.title!);
            return _newComponentView(responseNews);
          },
          separatorBuilder: (context, index){
            return const SizedBox(height: 16);
          },
          itemCount: controller.vogueResponseOnlyData!.news!.length
        );
  }

  Widget _newComponentView(News news){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      height: 81,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(76, 0, 0, 0),
            blurRadius: 10,
            offset: Offset(1, 2), // changes position of shadow
          ),
        ]
      ),
      child: InkWell(
        onTap: (){
          Get.to(WebviewWidget(weburl: news.link!));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset(
                "assets/images/news_source/naver.png"
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      news.title ?? "제목 없음",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 55, 71, 79)
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      news.content ?? "제목 없음",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: const Color.fromARGB(255, 55, 71, 79).withOpacity(0.6)
                      ),
                    )
                  ],
                ),
              )
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                "assets/icons/expand.svg"
              ),
            )
          ],
        ),
      ),
    );
  }
}
