import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:newz/config/routes/app_routes.dart';

import '../controller/introduction_controller.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(IntroductionController());

    CarouselController carouselController = CarouselController();
    List<Map<String, dynamic>> carouselItem = [
      {"id": 1, "text1": "나만의 관심사를 설정", "text2": "원하는 기사를 보여드려요"},
      {"id": 2, "text1": "넘치는 기사들 사이에서", "text2": "원하는 기사를 요약해드려요"},
      {"id": 3, "text1": "관심있는 기사는", "text2": "스크랩해서 저장해볼까요"},
    ];

    final deviceWidth = MediaQuery.of(context).size.width;
    const standardDeviceWidth = 360;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 56,
          ),
          const SizedBox(height: 20),
          Obx(
            () => Column(
              children: [
                Text(
                  carouselItem[IntroductionController.to.carouselIndex.value]
                      ['text1'],
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  carouselItem[IntroductionController.to.carouselIndex.value]
                      ['text2'],
                  style: const TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntroductionController.to.carouselIndex.value == 0
                        ? rectangleIndicator()
                        : dotIndicator(),
                    IntroductionController.to.carouselIndex.value == 1
                        ? rectangleIndicator()
                        : dotIndicator(),
                    IntroductionController.to.carouselIndex.value == 2
                        ? rectangleIndicator()
                        : dotIndicator(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, changeReason) {
                  IntroductionController.to.changeCarouselIndex(index);
                },
              ),
              carouselController: carouselController,
              items: carouselItem.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: 200 * (deviceWidth / standardDeviceWidth),
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Image(
                        image:
                            AssetImage('assets/images/intro_${item['id']}.png'),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: IntroductionController.to.carouselIndex.value == 2
                    ? const Color(0xFF3F51B5)
                    : const Color(0xFFC5CAE9),
              ),
              child: TextButton(
                onPressed: IntroductionController.to.carouselIndex.value == 2
                    ? () {
                        Get.toNamed(AppRoutes.introductionFinal);
                      }
                    : null,
                child: const Text(
                  "시작하기",
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  rectangleIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: Container(
        height: 8,
        width: 26,
        decoration: BoxDecoration(
          color: const Color(0xFF3F51B5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  dotIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 4,
      ),
      child: const Icon(
        Icons.circle,
        color: Color(0xFFC5CAE9),
        size: 10,
      ),
    );
  }
}
