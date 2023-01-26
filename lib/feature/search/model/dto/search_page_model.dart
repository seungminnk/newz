import 'package:get/get.dart';

class SearchPageModel{

  RxString searchKeyword = RxString("");
  RxBool isLoading = RxBool(false);
  bool isLastPage = false;
  int page = 1;
  int size = 15;

  @override
  String toString() {
    return """
      searchKeyword : ${searchKeyword},
      isLoading : ${isLoading},
      isLastPage : ${isLastPage},
      page : ${page},
      size : ${size}
    """;
  }
}