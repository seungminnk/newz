import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newz/config/network/dio_manager.dart';

class KeywordListController extends GetxController {
  static KeywordListController get to => Get.find<KeywordListController>();

  RxSet<String> enteredKeywords = <String>{}.obs;
  RxList<String> fixedKeywords = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();

    final dio = Dio();
    final response = await DioManager.instance.dio.get("/keyword/fixed/list");

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
