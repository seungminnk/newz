import 'package:newz/feature/search/model/dto/search_response_only_data_dto.dart';

class SearchPageModel{

  bool isLoading = false;
  bool isLastPage = false;
  int page = 1;
  int size = 10;

  @override
  String toString() {
    return """
      isLoading : ${isLoading},
      isLastPage : ${isLastPage},
      page : ${page},
      size : ${size},
    """;
  }
}