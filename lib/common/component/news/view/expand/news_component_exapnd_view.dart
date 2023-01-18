import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/mypage/view/webview_page.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

typedef TapCallback = void Function();

class NewsComponentExpandView extends StatefulWidget {
  const NewsComponentExpandView({
    required this.news,
    required this.onTap,
    Key? key
  }) : super(key: key);

  final News news;
  final TapCallback onTap;
  final Color fontColor = const Color.fromARGB(255, 55, 71, 79);

  @override
  State<NewsComponentExpandView> createState() => _NewsComponentExpandViewState();
}

class _NewsComponentExpandViewState extends State<NewsComponentExpandView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 286,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color: Colors.white,
          // boxShadow: const [
          //   BoxShadow(
          //     color: Color.fromARGB(76, 11, 15, 53),
          //     blurRadius: 10,
          //     offset: Offset(1, 3), // changes position of shadow
          //   ),
          // ]),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.news.title ?? "제목 없음",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: widget.fontColor),
                  ),
                ),
                const SizedBox(width: 18),
                InkWell(
                  onTap: () {
                    widget.onTap();
                  },
                  child: SizedBox(
                    width: 21.5,
                    height: 21.5,
                    child: SvgPicture.asset("assets/icons/shrink.svg"),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            width: double.infinity,
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.news.content ?? "기사 내용 없음..",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 16.0,
                      color: widget.fontColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: const Divider(
              thickness: 1.0,
              color: Color.fromARGB(255, 120, 144, 156),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Image.asset(
                  "assets/images/news_source/naver.png",
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => Get.to(WebviewWidget(weburl: widget.news.link!)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "자세히보기..",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: widget.fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  "assets/icons/scrap.svg",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
