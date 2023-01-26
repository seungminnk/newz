import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_data_controller.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_keyword_controller.dart';
import 'package:newz/feature/search/controller/search_result_controller.dart';

class SearchController extends GetxController{

  final SearchResultController searchResultController = Get.find();

  final RealTimeVogueKeywordController realTimeVogueKeywordController = Get.find();
  final RealTimeVogueDataController realTimeVogueDataController = Get.find();

  late TextEditingController searchTextEditingController;

  RxBool isTextEmpty = RxBool(true);

  void setTextAndStateOfTextWhenSubmitted(searchKeyword){
    searchResultController.searchPageModel.searchKeyword(searchKeyword);
    isTextEmpty(searchResultController.searchPageModel.searchKeyword.isEmpty);
    // searchResultController.requestSearchKeywordDataToServer();
  }

  void resetSearchTextField(){
    searchTextEditingController.text = "";
  }

  void initTextEditingController(){

    searchTextEditingController = TextEditingController();

    searchTextEditingController.addListener(() {
      if(searchTextEditingController.text.isEmpty){
        searchResultController.searchPageModel.searchKeyword("");
        isTextEmpty(searchResultController.searchPageModel.searchKeyword.isEmpty);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();

    initTextEditingController();

    realTimeVogueKeywordController.init();
    realTimeVogueDataController.init();

    realTimeVogueKeywordController.requestVogueKeyword();
  }

  @override
  void dispose() {
    super.dispose();
    searchTextEditingController.dispose();
  }
}