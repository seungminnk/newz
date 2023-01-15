import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_keyword_dto.dart';

class RealTimeVogueKeywordController extends GetxController{
  Dio? _dio;

  RxBool isLoading = false.obs;
  RxList<RealTimeVogueResponseOnlyKeywordDto> vogueResponseOnlyKeywordList = <RealTimeVogueResponseOnlyKeywordDto>[].obs;

  void requestVogueKeyword() async{
    isLoading.value = true;

    Dio dio = _getDio();

    var response = await dio.get("/news/vogue/keyword");

    vogueResponseOnlyKeywordList.clear();
    vogueResponseOnlyKeywordList.addAll(
      (response.data as List)
          .map((responseData) => RealTimeVogueResponseOnlyKeywordDto.fromJson(responseData))
    );

    isLoading.value = false;

    print("VOGUE KEYWORD REQUEST : ${vogueResponseOnlyKeywordList.map((element) => element.keyword)}");

  }

  Dio _getDio(){
    var baseOption = BaseOptions(
      baseUrl: "https://newz.bbear.kr/api",
      connectTimeout: 5000,
      receiveTimeout: 3000
    );

    _dio ??= Dio(baseOption);

    return _dio!;
  }
}