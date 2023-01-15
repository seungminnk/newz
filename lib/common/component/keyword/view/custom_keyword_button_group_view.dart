import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/keyword_button_shape_view.dart';

typedef _ClickedCb = void Function(KeywordRadioModel clickedValue);

class CustomKeywordButtonGroupView extends StatefulWidget {
  const CustomKeywordButtonGroupView({
    required this.keywordRadioModelList,
    required this.clickCb,
    Key? key,
  }) : super(key: key);

  final List<KeywordRadioModel> keywordRadioModelList;
  final _ClickedCb clickCb;

  @override
  State<CustomKeywordButtonGroupView> createState() => _CustomKeywordButtonGroupViewState();
}

class _CustomKeywordButtonGroupViewState extends State<CustomKeywordButtonGroupView> {
  List<KeywordRadioModel> sampleData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var element in widget.keywordRadioModelList) {
      sampleData.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: _buildKeywordButtons(sampleData, widget.clickCb),
    );
  }

  Widget _keywordButtonWrappedView(List<KeywordRadioModel> keywordRadioModelList, _ClickedCb clickedCb, index){
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: () {
        setState(() {
          for (var keywordRadioModel in keywordRadioModelList) {
            keywordRadioModel.isSelected = false;
          }
          keywordRadioModelList[index].isSelected = true;
          clickedCb(keywordRadioModelList[index]);
        });

      },
      child: KeywordButtonShapeView(keywordRadioModelList[index]),
    );
  }

  List<Widget> _buildKeywordButtons(List<KeywordRadioModel> keywordRadioModelList, _ClickedCb clickedCb){
    List<Widget> widgetList = [];
    int lastIndex = keywordRadioModelList.length - 1;

    for(int index = 0; index < keywordRadioModelList.length; index++){
      widgetList.add(
          _keywordButtonWrappedView(keywordRadioModelList, clickedCb, index)
      );
    }

    return widgetList;
  }
}
