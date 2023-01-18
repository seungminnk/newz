import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/one_time_use/keyword_button_shape_view.dart';

typedef _ClickedCb = void Function(KeywordRadioModel clickedValue);

class CustomKeywordButtonGroupView extends StatefulWidget {
  const CustomKeywordButtonGroupView({
    required this.keywordRadioModelList,
    required this.clickCb,
    this.alignment = WrapAlignment.start,
    this.isHorizontalListView = false,
    Key? key,
  }) : super(key: key);

  final List<KeywordRadioModel> keywordRadioModelList;
  final _ClickedCb clickCb;

  final WrapAlignment alignment;
  final bool isHorizontalListView;

  @override
  State<CustomKeywordButtonGroupView> createState() =>
      _CustomKeywordButtonGroupViewState();
}

class _CustomKeywordButtonGroupViewState
    extends State<CustomKeywordButtonGroupView> {
  List<KeywordRadioModel> sampleData = [];

  @override
  void initState() {
    super.initState();

    for (var element in widget.keywordRadioModelList) {
      sampleData.add(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _handleWidgetView(isHorizontalListView: widget.isHorizontalListView);
  }

  Widget _handleWidgetView({bool isHorizontalListView = false}) {
    List<Widget> buttonListWidget =
        _buildKeywordButtons(sampleData, widget.clickCb);

    if (isHorizontalListView) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return buttonListWidget[index];
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 8.0);
          },
          itemCount: buttonListWidget.length,
      );
    } else {
      return Wrap(
        alignment: widget.alignment,
        spacing: 8.0,
        runSpacing: 10.0,
        children: buttonListWidget,
      );
    }
  }

  Widget _keywordButtonWrappedView(
      List<KeywordRadioModel> keywordRadioModelList,
      _ClickedCb clickedCb,
      index) {
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

  List<Widget> _buildKeywordButtons(
      List<KeywordRadioModel> keywordRadioModelList, _ClickedCb clickedCb) {
    List<Widget> widgetList = [];

    for (int index = 0; index < keywordRadioModelList.length; index++) {
      widgetList.add(
          _keywordButtonWrappedView(keywordRadioModelList, clickedCb, index));
    }

    return widgetList;
  }
}
