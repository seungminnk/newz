import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/mypage/controller/bookmark_controller.dart';
import 'package:get/get.dart';
import '../../login/controller/login_controller.dart';
import '../../onboarding/controller/keyword_editing_controller.dart';
import '../../onboarding/controller/keyword_list_controller.dart';
import 'webview_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final bookmarkController = Get.put(Bookmarkcontroller());
  final keywordListController = Get.put(KeywordListController());
  final loginController = Get.put(LoginController());
  final keywordEditingController = Get.put(KeywordEditingController());

  @override
  void initState() {
    bookmarkController.fetchBookmark('1');
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
              UserInfoWidget(loginController: loginController),
              const SizedBox(height: 20),
              Image.asset('assets/images/Line.png'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '내 키워드 9개',
                    style: TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                      onTap: () {
                        bookmarkController.keywordSettingButtonClick();
                      },
                      child: Row(
                        children: [
                          const Text('키워드 변경'),
                          const SizedBox(width: 5),
                          SvgPicture.asset('assets/icons/mypage_setting.svg'),
                        ],
                      )),
                ],
              ),
              const SizedBox(height: 20),
              KeywordListCard(
                bookmarkController: bookmarkController,
                keywordListController: keywordListController,
                keywordEditingController: keywordEditingController,
              ),
              const SizedBox(height: 20),
              addKeyword(bookmarkController: bookmarkController),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '스크랩',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const ScrapCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class addKeyword extends StatelessWidget {
  const addKeyword({
    Key? key,
    required this.bookmarkController,
  }) : super(key: key);

  final Bookmarkcontroller bookmarkController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => bookmarkController.isBookmark.isFalse
          ? const SizedBox(height: 20)
          : Container(
              height: 40,
              padding: EdgeInsets.zero,
              margin: const EdgeInsets.only(
                top: 0,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: _enteredKeyword,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "원하는 키워드를 적어보아요",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    child: const Icon(
                      Icons.cancel,
                      size: 14,
                    ),
                    onTap: () => {KeywordEditingController.to.clear()},
                  ),
                ),
              ),
            ),
    );
  }
}

void _enteredKeyword(String text) {
  KeywordListController.to.addKeyword(text);
  KeywordEditingController.to.clear();
}

class KeywordListCard extends StatelessWidget {
  const KeywordListCard(
      {Key? key,
      required this.bookmarkController,
      required this.keywordListController,
      required this.keywordEditingController})
      : super(key: key);

  final Bookmarkcontroller bookmarkController;

  final KeywordListController keywordListController;

  final KeywordEditingController keywordEditingController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        height: 40,
        child: ListView.separated(
          // FIXME 패딩이 있는 횡스크롤은 스크롤중에 항목이 잘립니다. "clipBehavior: Clip.none" 값을 주면, 최종 좌우 여백은 지키면서도, 스크롤중에는 잘려보이지 않습니다.
          scrollDirection: Axis.horizontal,
          itemCount: keywordListController.fixedKeywords.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10);
          },
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                color: Colors.transparent,
              ),
              child: Obx(
                () => Center(
                  child: bookmarkController.isBookmark.isFalse
                      ? Row(
                          children: [
                            Text(keywordListController.fixedKeywords[index]),
                          ],
                        )
                      : Row(
                          children: [
                            Text(keywordListController.fixedKeywords[index]),
                            const SizedBox(width: 5),
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(Icons.cancel_outlined,
                                    size: 18)),
                          ],
                        ),
                ),
              ),
            );
          },
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
  final bookmarkController = Get.put(Bookmarkcontroller());

  final ScrollController _scrollController = ScrollController();

  void _scrollToSelectedContent(
      bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
    final keyContext = myKey.currentContext;

    if (keyContext != null) {
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
        itemCount: bookmarkController.bookmarklist.length,
        itemBuilder: (context, index) {
          var bookmarks = bookmarkController.bookmarklist[index];
          return ExpansionTileCard(
            baseColor: Colors.grey[200],
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            leading: const CircleAvatar(child: Text('N')),
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
                      bookmarkController.removeButtonClick(bookmarks.userid);
                    },
                    child: Column(
                      children: const [
                        Icon(Icons.remove_circle_outline),
                        SizedBox(height: 3),
                        Text('제거하기'),
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

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final LoginController loginController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              loginController.isLogin.isFalse
                  ? const Text(
                      '길동님',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      '${loginController.userData.displayName!}님',
                      style: const TextStyle(
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
          loginController.isLogin.isFalse
              ? const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/userprofil.png'),
                )
              : Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(loginController.userData.photoUrl!)),
        ],
      ),
    );
  }
}
