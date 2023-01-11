import 'package:dio/dio.dart';
import 'package:get/get.dart';

class KeywordListController extends GetxController {
  static KeywordListController get to => Get.find<KeywordListController>();

  RxSet<String> enteredKeywords = <String>{}.obs;
  RxList<String> fixedKeywords = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();

    final dio = Dio();
    final response =
        await dio.get("http://localhost:3001/api/fixed-keyword/list");

    for (var keyword in response.data) {
      fixedKeywords.add(keyword);
    }

    dio.close();
  }

  void addKeyword(String keyword) {
    enteredKeywords.add(keyword);
  }

  void removeKeyword(String keyword) {
    enteredKeywords.remove(keyword);
  }
}
