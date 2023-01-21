import 'package:get/get.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/search/model/search_response_only_data_dto.dart';

class SearchDataController extends GetxController{

  RxBool isLoading = RxBool(false);

  final int size = 10;
  
  void requestSearchKeywordData(int page) async{

    isLoading.value = true;

    var response = await DioManager.instance.dio.get(
      "/news/list",
      queryParameters: {
        'query': "손흥민",
        'page':page,
        'size':size
      },
    );

    SearchResponseOnlyDataDto searchResponseOnlyDataDto = SearchResponseOnlyDataDto.fromJson(response.data);

    print("검색 요청 데이터 : ${searchResponseOnlyDataDto.toJson()}");

    isLoading.value = false;
  }
  
}