import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/custom_keyword_button_group_view.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_keyword_controller.dart';
import 'package:newz/feature/real_time_vogue/view/real_time_vogue_data_view.dart';

class RealTimeVogueView extends StatelessWidget {
  const RealTimeVogueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RealTimeVogueKeywordController realTimeVogueKeywordController = Get.find();
    RealTimeVogueDataController realTimeVogueDataController = Get.find();

    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          margin: const EdgeInsets.only(bottom: 15.0),
          child: const Text(
            "지금 사람들이 많이 검색하는 키워드예요",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff37474f),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => realTimeVogueKeywordController.isLoading.value
                ? const Align(
                    alignment: Alignment.topCenter,
                    child: CustomCircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Builder(
                        builder: (context) {

                          List<KeywordRadioModel> keywordRadioModelList = KeywordRadioModel.fromVogueKeywordRequest(realTimeVogueKeywordController.vogueResponseOnlyKeywordList);

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomKeywordButtonGroupView(
                              keywordRadioModelList: keywordRadioModelList,
                              clickCb: (KeywordRadioModel clickedValue) {
                                realTimeVogueDataController.requestVogueData(clickedValue.value);
                              },
                            ),
                          );
                        }
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      Obx(
                        () => realTimeVogueDataController.isLoading.value
                            ? const Align(
                                alignment: Alignment.topCenter,
                                child: CustomCircularProgressIndicator(),
                              )
                            : const Expanded(
                                child: RealTimeVogueDataView(),
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
