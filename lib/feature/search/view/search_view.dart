import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/custom_keyword_button_group_view.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/feature/home/components/keyword_box.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_keyword_controller.dart';
import 'package:newz/feature/real_time_vogue/view/real_time_vogue_data_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  RealTimeVogueKeywordController realTimeVogueKeywordController = Get.find();
  RealTimeVogueDataController realTimeVogueDataController = Get.find();

  final _searchController = TextEditingController();
  final List _keywordList = [];
  final List keyword = [
    'Text',
    'Text',
    'Text',
    'Text',
    'Text',
    'Text',
    'Text',
    'Text',
    'Text',
    'Text'
  ];
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;
  String _searchText = "";

  @override
  void initState() {
    super.initState();

    realTimeVogueKeywordController.requestVogueKeyword();

    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _focusNode.addListener(() {
      _onFocusChange();
    });
  }

  void _onFocusChange() {
    setState(() {
      isFocus = !isFocus;
    });
  }

  void _unFocus() {
    _focusNode.unfocus();
    _searchController.clear();
  }

  _SearchViewState() {
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: const Text(
          "검색",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff37474f),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/sort.svg"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _searchController,
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
                          fontWeight: FontWeight.w400),
                      suffixIcon: GestureDetector(
                        onTap: _unFocus,
                        child: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 21),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "지금 사람들이 많이 검색하는 키워드예요",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff37474f),
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Expanded(
            child: _searchController.text.isNotEmpty
                // TODO 여기서 검색된 컨텐츠들 내용 뿌려주면 될듯 싶습니다.
                ? const Text("검색중입니다..")
                : Obx(
                    () => realTimeVogueKeywordController.isLoading.value ?
                      const Align(
                        alignment: Alignment.topCenter,
                        child: CustomCircularProgressIndicator(),
                      )
                      :
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomKeywordButtonGroupView(
                              keywordRadioModelList: KeywordRadioModel.fromVogueKeywordRequest(realTimeVogueKeywordController.vogueResponseOnlyKeywordList),
                              clickCb: (KeywordRadioModel clickedValue) {
                                realTimeVogueDataController.requestVogueData(clickedValue.value);
                              },
                            ),
                          ),
                          const SizedBox(height: 27,),
                          Obx(
                            () => realTimeVogueDataController.isLoading.value
                                ?
                                const Align(
                                  alignment: Alignment.topCenter,
                                  child: CustomCircularProgressIndicator(),
                                )
                                :
                                const Expanded(
                                  child: RealTimeVogueDataView(),
                                ),
                          ),
                        ],
                      ),
                  ),
          ),
        ],
      ),
    );
  }
}
