import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/mypage/view/webview_page.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

typedef TapCallback = void Function();

class NewsComponentSummaryView extends StatelessWidget {
  const NewsComponentSummaryView({
    required this.news,
    required this.onTap,
    Key? key
  }) : super(key: key);

  final News news;
  final TapCallback onTap;

  @override
  Widget build(BuildContext context) {
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
          ]),
      child: InkWell(
        onTap: () {
          Get.to(WebviewWidget(weburl: news.link!));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: Image.asset("assets/images/news_source/naver.png"),
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
                            fontSize: 16.0, color: Color.fromARGB(255, 55, 71, 79)),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        news.content ?? "제목 없음",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 55, 71, 79)
                                .withOpacity(0.6)),
                      )
                    ],
                  ),
                )),
            InkWell(
              onTap: (){
                onTap();
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset("assets/icons/expand.svg"),
              ),
            )
          ],
        ),
      ),
    );
  }

}
