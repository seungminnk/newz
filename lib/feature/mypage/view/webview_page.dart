import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/login/controller/login_controller.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';

class WebviewWidget extends StatefulWidget {
  final String weburl;
  const WebviewWidget({super.key, required this.weburl});

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final mypageController = Get.put(Mypagecontroller());
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    // TODO:
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (() {
            Get.back();
          }),
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                if (loginController.userName.isEmpty) {
                  errorScrapDialog(context);
                } else {
                  scrapDialog(context);
                  mypageController.webViewScrapBtn(widget.weburl);
                }
              },
              icon: SvgPicture.asset("assets/icons/scrap.svg"))
        ],
      ),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.weburl),
          ),
        ),
      ),
    );
  }

  Future<dynamic> errorScrapDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SizedBox(
              height: 100,
              width: 312,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "로그인이 필요한 서비스입니다.",
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        color: Color(0xff37474f),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 128,
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
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Future<dynamic> scrapDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            content: SizedBox(
              height: 260,
              width: 312,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                        width: 160,
                        height: 120,
                        child: Image.asset('assets/images/IMAGE.png')),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 264,
                      height: 123,
                      child: Column(
                        children: [
                          const Text(
                            "저장 완료",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 18,
                              color: Color(0xff37474f),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "관심기사를 '스크랩'에 저장하였습니다.",
                            style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 14,
                              color: Color(0xff78909C),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: 128,
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
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: 128,
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: const Color(0xFFC5CAE9),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '취소',
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
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
