import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_keyword_dto.dart';

class RealTimeVogueKeywordController extends GetxController{
  Dio? _dio;

  RxBool isLoading = false.obs;
  RxList<RealTimeVogueResponseOnlyKeywordDto> vogueResponseOnlyKeywordList = <RealTimeVogueResponseOnlyKeywordDto>[].obs;

  void requestVogueKeyword() async{
    isLoading.value = true;

    Dio dio = _getDio();

    dio_response.Response<List<dynamic>> response = await dio.get("/news/vogue/keyword");

    vogueResponseOnlyKeywordList.clear();

    if(10 <= response.data!.length){
      vogueResponseOnlyKeywordList.addAll(
        response.data!
            .sublist(0, 10)
            .map((responseData) => RealTimeVogueResponseOnlyKeywordDto.fromJson(responseData))
      );
    }
    else{
      vogueResponseOnlyKeywordList.addAll(
        response.data!.map((responseData) => RealTimeVogueResponseOnlyKeywordDto.fromJson(responseData))
      );
    }

    isLoading.value = false;

    print("VOGUE KEYWORD REQUEST : ${vogueResponseOnlyKeywordList.map((element) => element.keyword)}");

  }

  // FIXME dio는 한군데에서 선언해서 사용하거나, 설정을 공유 할 수 있도록 만들어주세요.
  Dio _getDio(){
    var baseOption = BaseOptions(
      baseUrl: "https://newz.bbear.kr/api",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio ??= Dio(baseOption);

    return _dio!;
  }

  void init(){
    isLoading.value = false;
    vogueResponseOnlyKeywordList.clear();
  }
}