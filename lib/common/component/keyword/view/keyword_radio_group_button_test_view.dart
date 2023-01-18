import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/custom_keyword_button_group_view.dart';

class KeywordRadioGroupButtonTestView extends StatelessWidget {
  const KeywordRadioGroupButtonTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<KeywordRadioModel> list = [];
    list.add(KeywordRadioModel(false, 'AAAAA', 'April 18'));
    list.add(KeywordRadioModel(false, 'BBBBB', 'April 17'));
    list.add(KeywordRadioModel(false, 'CCCCC', 'April 16'));
    list.add(KeywordRadioModel(false, 'DDDDD', 'April 15'));
    list.add(KeywordRadioModel(false, 'EEEEE', 'April 14'));
    list.add(KeywordRadioModel(false, 'FFFFF', 'April 13'));
    list.add(KeywordRadioModel(false, 'GGGGG', 'April 12'));

    return Scaffold(
      appBar: AppBar(title: const Text('키워드 그룹 테스트')),
      body: SizedBox(
        height: 30,
        child: CustomKeywordButtonGroupView(
          keywordRadioModelList: list,
          clickCb: (modelValue){
            print("중요한 손님 지나갑니다! : ${modelValue.value}");
          },
          isHorizontalListView: true,
        ),
      ),
    );
  }
}
