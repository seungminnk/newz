import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';
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
  final mypageController = Get.put(Mypagecontroller());
  final keywordListController = Get.put(KeywordListController());
  final loginController = Get.put(LoginController());
  final keywordEditingController = Get.put(KeywordEditingController());

  @override
  void initState() {
    mypageController.fetchBookmark('1');
    mypageController.fetchKeyword('1');
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
                  Text(
                    '내 키워드 ${mypageController.keywordlist.length}개',
                    style: const TextStyle(fontSize: 15),
                  ),
                  GestureDetector(
                      onTap: () {
                        mypageController.keywordSettingButtonClick();
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
                mypageController: mypageController,
                keywordListController: keywordListController,
                keywordEditingController: keywordEditingController,
              ),
              const SizedBox(height: 20),
              addKeyword(mypageController: mypageController),
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
    required this.mypageController,
  }) : super(key: key);

  final Mypagecontroller mypageController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => mypageController.isBookmark.isFalse
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
      required this.mypageController,
      required this.keywordListController,
      required this.keywordEditingController})
      : super(key: key);

  final Mypagecontroller mypageController;

  final KeywordListController keywordListController;

  final KeywordEditingController keywordEditingController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        height: 35,
        child: ListView.separated(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          itemCount: mypageController.keywordlist.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(width: 10);
          },
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Obx(
                () => Center(
                  child: mypageController.isBookmark.isFalse
                      ? Row(
                          children: [
                            Text(
                              mypageController.keywordlist[index],
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(mypageController.keywordlist[index],
                                style: TextStyle(color: Colors.grey[600])),
                            const SizedBox(width: 5),
                            GestureDetector(
                                onTap: () {
                                  // 키워드 삭제 구현 필요
                                  mypageController.keywordRemoveBtn('1');
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 18,
                                  color: Colors.grey[600],
                                )),
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
  final mypageController = Get.put(Mypagecontroller());

  // 스크롤 영역 확장 코드
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
        itemCount: mypageController.bookmarklist.length,
        itemBuilder: (context, index) {
          var bookmarks = mypageController.bookmarklist[index];
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
                      // 북마크 제거 기능
                      mypageController.bookmarkRemoveBtn(bookmarks.userid);
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
