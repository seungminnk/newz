import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';

class WebviewWidget extends StatefulWidget {
  final String weburl;
  const WebviewWidget({super.key, required this.weburl});

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  final mypageController = Get.put(Mypagecontroller());
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
                mypageController.webViewScapBtn(widget.weburl);
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
}
