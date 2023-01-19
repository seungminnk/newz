import 'package:flutter/material.dart';
import 'package:newz/application/routes/app_routes.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/common/component/news/view/news_component_view.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';
import 'package:get/get.dart';
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
                UserInfoWidget(),
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
                KeywordListCard(),
                const SizedBox(height: 20),
                addKeyword(),
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
                BookmarkCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BookmarkCardWidget extends StatelessWidget {
  BookmarkCardWidget({Key? key}) : super(key: key);

  final Mypagecontroller mypageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mypageController.isBookmarkLoading.isFalse
        ? const CustomCircularProgressIndicator()
        : ListView.separated(
            shrinkWrap: true,
            itemCount: mypageController.bookmarklist.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: ((context, index) {
              var news = mypageController.bookmarklist[index];
              return GestureDetector(
                onLongPress: () {
                  bookmarkDialog(context, news);
                },
                child: NewsComponentView(
                  title: news.title,
                  content: news.content,
                  link: news.link,
                ),
              );
            }),
          ));
  }

  Future<dynamic> bookmarkDialog(BuildContext context, news) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SizedBox(
              height: 150,
              width: 312,
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (() {
                            Get.back();
                          }),
                          icon: SvgPicture.asset('assets/icons/cancel.svg'),
                        )
                      ],
                    ),
                    const Text(
                      "해당 스크랩을 삭제하시겠어요?",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            mypageController
                                .bookmarkRemoveBtn(news.bookmarkId.toString());
                            Get.back();
                          },
                          child: Container(
                            width: 80,
                            height: 44,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF3F51B5),
                            ),
                            child: const Center(
                              child: Text(
                                '확인',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            width: 80,
                            height: 44,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                            child: const Center(
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class UserInfoWidget extends StatelessWidget {
  UserInfoWidget({Key? key}) : super(key: key);

  final LoginController loginController = Get.find();
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

class addKeyword extends StatelessWidget {
  addKeyword({Key? key}) : super(key: key);

  final Mypagecontroller mypageController = Get.find();

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
  KeywordListCard({Key? key}) : super(key: key);

  final Mypagecontroller mypageController = Get.find();

  final KeywordListController keywordListController = Get.find();

  final KeywordEditingController keywordEditingController = Get.find();

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
