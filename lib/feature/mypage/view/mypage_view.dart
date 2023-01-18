import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';
import 'package:get/get.dart';
import 'package:newz/feature/mypage/view/webview_page.dart';
import '../../login/controller/login_controller.dart';
import '../../onboarding/controller/keyword_editing_controller.dart';
import '../../onboarding/controller/keyword_list_controller.dart';
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
      body: Obx(
        () => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                UserInfoWidget(loginController: loginController),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                        child: Image.asset(
                      'assets/images/Line.png',
                      fit: BoxFit.fill,
                    )),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '내 키워드 ${mypageController.keywordlist.length}개',
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 12,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          mypageController.keywordSettingButtonClick();
                        },
                        child: Row(
                          children: [
                            const Text(
                              '키워드 변경',
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 12,
                                color: Color(0xff37474f),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 10),
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
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                //const ScrapCardWidget(),
                BookmarkCardWidget(mypageController: mypageController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookmarkCardWidget extends StatefulWidget {
  const BookmarkCardWidget({
    Key? key,
    required this.mypageController,
  }) : super(key: key);

  final Mypagecontroller mypageController;

  @override
  State<BookmarkCardWidget> createState() => _BookmarkCardWidgetState();
}

class _BookmarkCardWidgetState extends State<BookmarkCardWidget> {
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

  bool _isExpanded = false;

  void _onTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  final Color fontColor = const Color.fromARGB(255, 55, 71, 79);

  @override
  Widget build(BuildContext context) {
    return Obx(() => widget.mypageController.isBookmarkLoading.isFalse
        ? const CustomCircularProgressIndicator()
        : _isExpanded
            ? cardExpand()
            : cardSummary());
  }

  ListView cardExpand() {
    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: widget.mypageController.bookmarklist.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: ((context, index) {
        var news = widget.mypageController.bookmarklist[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 286,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(76, 11, 15, 53),
                  blurRadius: 10,
                  offset: Offset(1, 3), // changes position of shadow
                ),
              ]),
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
                        news.title ?? "제목 없음",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, color: fontColor),
                      ),
                    ),
                    const SizedBox(width: 18),
                    InkWell(
                      onTap: () {
                        _onTap();
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
                        news.content ?? "기사 내용 없음..",
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 16.0,
                          color: fontColor,
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
                      onTap: () => Get.to(WebviewWidget(weburl: news.link!)),
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
                                color: fontColor,
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
      }),
    );
  }

  ListView cardSummary() {
    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: true,
      itemCount: widget.mypageController.bookmarklist.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
      itemBuilder: ((context, index) {
        var news = widget.mypageController.bookmarklist[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 81,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(76, 11, 15, 53),
                  blurRadius: 10,
                  offset: Offset(1, 3), // changes position of shadow
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
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 55, 71, 79)),
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
                  onTap: () {
                    _onTap();
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
      }),
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
      () => mypageController.changeKeyword.isFalse
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
      () => mypageController.isKeywordLoading.isFalse
          ? const CustomCircularProgressIndicator()
          : SizedBox(
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
                      borderRadius: BorderRadius.circular(8.0),
                      color: const Color.fromARGB(255, 236, 239, 241),
                    ),
                    child: Obx(
                      () => Center(
                        child: mypageController.changeKeyword.isFalse
                            ? Row(
                                children: [
                                  Text(
                                    mypageController.keywordlist[index],
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 120, 144, 156)),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Text(mypageController.keywordlist[index],
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 120, 144, 156))),
                                  const SizedBox(width: 5),
                                  GestureDetector(
                                      onTap: () {
                                        // 키워드 삭제 구현 필요
                                        mypageController.keywordRemoveBtn(
                                            '1',
                                            mypageController
                                                .keywordlist[index]);
                                      },
                                      child: const Icon(
                                        Icons.cancel_outlined,
                                        size: 18,
                                        color:
                                            Color.fromARGB(255, 120, 144, 156),
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
      () => mypageController.isBookmarkLoading.isFalse
          ? const CustomCircularProgressIndicator()
          : ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: mypageController.bookmarklist.length,
              itemBuilder: (context, index) {
                var bookmarks = mypageController.bookmarklist[index];
                return ExpansionTileCard(
                  baseColor: Colors.white,
                  shadowColor: const Color.fromARGB(76, 11, 15, 53),
                  borderRadius: BorderRadius.circular(20),
                  leading: SizedBox(
                    width: 48,
                    height: 48,
                    child: Image.asset("assets/images/news_source/naver.png"),
                  ),
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
                            print(bookmarks.bookmarkId.toString());
                            // 북마크 제거 기능
                            mypageController.bookmarkRemoveBtn(
                                bookmarks.bookmarkId.toString());
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
                          onPressed: () => Get.to(
                              () => WebviewWidget(weburl: bookmarks.link)),
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

                // NewsComponentView(news: bookmarks);
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
                      '길동님\n관심 기사를 모아놨어요',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : Text(
                      '${loginController.userData.displayName!}님\n관심 기사를 모아놨어요',
                      style: const TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 20,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              // Text(loginController.googleSignInAuthentication.idToken
              //     .toString()),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  '정보수정',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 14,
                    color: Color(0xff37474f),
                    fontWeight: FontWeight.w400,
                  ),
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
