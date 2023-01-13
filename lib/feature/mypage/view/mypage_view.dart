import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/mypage/controller/scrap_controller.dart';
import 'package:get/get.dart';
import 'webview_page.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final scrapController = Get.put(ScrapController());

  @override
  void initState() {
    // scrapController.fetchBookmark('1');
    scrapController.fetchNews('커피');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Get.toNamed(AppRoutes.login);
          }),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '스크랩',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //  scrapController.fetchBookmark('1');
                    },
                    icon: const Icon(Icons.replay_outlined),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const ScrapCardWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '뉴스기사',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      scrapController.fetchNews('커피');
                    },
                    icon: const Icon(Icons.replay_outlined),
                  )
                ],
              ),
              const ScrapCardWidget2()
            ],
          ),
        ),
      ),
    );
  }
}

class ScrapCardWidget extends StatefulWidget {
  const ScrapCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ScrapCardWidget> createState() => _ScrapCardWidgetState();
}

class _ScrapCardWidgetState extends State<ScrapCardWidget> {
  final scrapController = Get.put(ScrapController());
  final ScrollController _scrollController = ScrollController();

  void _scrollToSelectedContent(
      bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _scrollController.animateTo(
          isExpanded ? (box.size.height * index) : previousOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: scrapController.bookmarklist.length,
        itemBuilder: (context, index) {
          var bookmarks = scrapController.bookmarklist[index];
          return ExpansionTileCard(
            baseColor: Colors.grey[200],
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            leading: const CircleAvatar(child: Text('A')),
            title: Text(bookmarks.title),
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
                    bookmarks.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      scrapController.scrapButtonClick(
                          title: bookmarks.title,
                          content: bookmarks.content,
                          link: bookmarks.link);
                    },
                    child: Column(
                      children: [
                        Icon(scrapController.bookmarklist
                                .contains(bookmarks.title)
                            ? Icons.favorite
                            : Icons.favorite_border),
                        const SizedBox(height: 3),
                        const Text('Like'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Get.to(() => WebviewWidget(weburl: bookmarks.link)),
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
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}

class ScrapCardWidget2 extends StatefulWidget {
  const ScrapCardWidget2({
    Key? key,
  }) : super(key: key);

  @override
  State<ScrapCardWidget2> createState() => _ScrapCardWidget2State();
}

class _ScrapCardWidget2State extends State<ScrapCardWidget2> {
  final scrapController = Get.put(ScrapController());
  final ScrollController _scrollController = ScrollController();
  void _scrollToSelectedContent(
      bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
      // make sure that your widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      _scrollController.animateTo(
          isExpanded ? (box.size.height * index) : previousOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
        controller: _scrollController,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: scrapController.newslist.length,
        itemBuilder: (context, index) {
          var newsData = scrapController.newslist[index];
          return ExpansionTileCard(
            baseColor: Colors.grey[200],
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            leading: const CircleAvatar(child: Text('A')),
            title: Text(newsData.title),
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
                    newsData.content,
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
                        scrapController.scrapButtonClick(
                            title: newsData.title,
                            content: newsData.content,
                            link: newsData.link);
                      },
                      child: Column(
                        children: [
                          Icon(scrapController.bookmarklist
                                  .contains(newsData.title)
                              ? Icons.favorite
                              : Icons.favorite_border),
                          const SizedBox(height: 3),
                          const Text('Like'),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Get.to(() => WebviewWidget(weburl: newsData.link)),
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
      ),
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
