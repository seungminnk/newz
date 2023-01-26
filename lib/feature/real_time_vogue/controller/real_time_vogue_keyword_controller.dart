import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;
import 'package:get/get.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_keyword_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RealTimeVogueKeywordController extends GetxController{

  RxBool isLoading = false.obs;
  RxList<RealTimeVogueResponseOnlyKeywordDto> vogueResponseOnlyKeywordList = <RealTimeVogueResponseOnlyKeywordDto>[].obs;

  void requestVogueKeyword() async{
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString("accessToken");
    String? refreshToken = prefs.getString("refreshToken");

    var dio = DioManager.instance.dio;
    dio.options.headers = {
      'x-newz-access-token': accessToken
    };

    dio_response.Response<List<dynamic>> response = await dio.get("/news/vogue/keyword",);

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

  void init(){
    isLoading.value = false;
    vogueResponseOnlyKeywordList.clear();
  }
}