import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:newz/feature/mypage/scrap_controller.dart';
import 'package:get/get.dart';
import '../news_api_model.dart';
import '../news_api_service.dart';
import 'webview_page.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {}),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const UserInfoWidget(),
              const SizedBox(height: 40),
              const ScrapTextWidget(),
              const SizedBox(height: 10),
              ScrapCardWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class ScrapCardWidget extends StatelessWidget {
  ScrapCardWidget({
    Key? key,
  }) : super(key: key);

  final scrapController = Get.put(ScrapController());

  final Future<List<NewsModel>> news = ApiService.getNewsData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var newz = snapshot.data![index];
              return ExpansionTileCard(
                baseColor: Colors.grey[200],
                shadowColor: Colors.grey,
                borderRadius: BorderRadius.circular(20),
                leading: const CircleAvatar(child: Text('A')),
                title: Text(newz.title),
                children: [
                  const Divider(
                    thickness: 1.0,
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        newz.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                  Obx(
                    () => ButtonBar(
                      alignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            scrapController.scrapButtonClick();
                          },
                          child: Column(
                            children: [
                              Icon(scrapController.isLiked.isTrue
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              const SizedBox(height: 3),
                              const Text('Like'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              Get.to(() => WebviewWidget(weburl: newz.link)),
                          child: Column(
                            children: const [
                              Icon(Icons.list_alt),
                              SizedBox(height: 3),
                              Text('원문 읽기'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class ScrapTextWidget extends StatelessWidget {
  const ScrapTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          '스크랩',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '길동님',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              '관심 기사를 모아놨어요',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                '정보수정',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
        const Icon(
          Icons.circle,
          color: Colors.grey,
          size: 100,
        ),
      ],
    );
  }
}
