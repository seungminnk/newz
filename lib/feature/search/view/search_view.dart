import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/view/real_time_vogue_view.dart';
import 'package:newz/feature/search/controller/search_controller.dart';
import 'package:newz/feature/search/view/search_news_view.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => Navigator.pop(context),
        //   color: Colors.black,
        // ),
        title: const Text(
          "검색",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff37474f),
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: SvgPicture.asset("assets/icons/sort.svg"),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchTextEditingController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (searchKeyword) {
                      controller.setTextAndStateOfTextWhenSubmitted(searchKeyword);
                    },
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        width: 24,
                        height: 24,
                        padding: EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                        ),
                      ),
                      hintText: '원하는 기사를 검색해봐요',
                      hintStyle: const TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff121212),
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: GestureDetector(
                        // onTap: _unFocus,
                        onTap: () {
                          controller.resetSearchTextField();
                        },
                        child: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(
              () {
                return controller.isTextEmpty.value
                    ? const RealTimeVogueView()
                    : const SearchNewsView();
              },
            ),
          ),
        ],
      ),
    );
  }
}
