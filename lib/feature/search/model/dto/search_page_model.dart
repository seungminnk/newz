import 'package:get/get.dart';

class SearchPageModel{

  RxString searchKeyword = RxString("");
  RxBool isLoading = RxBool(false);
  bool isLastPage = false;
  int page = 1;
  int size = 10;

  @override
  String toString() {
    return """
      isLoading : ${isLoading},
      isLastPage : ${isLastPage},
      page : ${page},
      size : ${size}
    """;
  }
}