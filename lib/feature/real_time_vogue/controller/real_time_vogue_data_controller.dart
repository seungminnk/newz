import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

class RealTimeVogueDataController extends GetxController{
  Dio? _dio;

  RxBool isLoading = false.obs;
  RealTimeVogueResponseOnlyDataDto? vogueResponseOnlyData;

  void requestVogueData(String keyword) async{
    isLoading.value = true;

    Dio dio = _getDio();

    var response = await dio.get(
        "/news/list",
      queryParameters: {
        'query': keyword,
        'page': 1,
        'limit': 3
      }
    );

    vogueResponseOnlyData = RealTimeVogueResponseOnlyDataDto.fromJson(response.data);

    print("REQUEST VOGUE DATA : ${vogueResponseOnlyData?.toJson()}");

    isLoading.value = false;
  }

  // FIXME dio는 한군데에서 선언해서 사용하거나, 설정을 공유 할 수 있도록 만들어주세요.
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