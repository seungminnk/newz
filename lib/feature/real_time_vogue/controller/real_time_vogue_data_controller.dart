import 'package:get/get.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart' as RealTimeVogueResponse;
import 'package:shared_preferences/shared_preferences.dart';

class RealTimeVogueDataController extends GetxController{

  RxBool isLoading = RxBool(false);

  RxString vogueKeyword = RxString("");
  List<RealTimeVogueResponse.News> vogueNewsList = <RealTimeVogueResponse.News>[];

  void requestVogueData(String keyword) async{
    vogueKeyword(keyword);

    print('지금 이 ${vogueKeyword.value} 를 클릭하였습니다.');

    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString("accessToken");
    String? refreshToken = prefs.getString("refreshToken");

    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};

    var response = await dio.get(
        "/news/list",
      queryParameters: {
        'query': keyword,
        'page': 1,
        'limit': 3
      }
    );

    RealTimeVogueResponse.RealTimeVogueResponseOnlyDataDto realTimeVogueResponseOnlyDataDto = RealTimeVogueResponse.RealTimeVogueResponseOnlyDataDto.fromJson(response.data);
    vogueNewsList = realTimeVogueResponseOnlyDataDto.news!;

    print("REQUEST VOGUE DATA : ${vogueNewsList.map((e) => e.toJson())}");

    if(isRequestKeywordSameAsStoredKeyword(keyword)){
      isLoading.value = false;
    }
  }

  bool isRequestKeywordSameAsStoredKeyword(String requestKeyword){
    return requestKeyword == vogueKeyword.value;
  }

  void init(){
    isLoading.value = false;
    vogueNewsList.clear();
  }
}