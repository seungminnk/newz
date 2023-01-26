import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RealTimeVogueDataController extends GetxController{

  RxBool isLoading = false.obs;
  RealTimeVogueResponseOnlyDataDto? vogueResponseOnlyData;

  void requestVogueData(String keyword) async{
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

    vogueResponseOnlyData = RealTimeVogueResponseOnlyDataDto.fromJson(response.data);

    print("REQUEST VOGUE DATA : ${vogueResponseOnlyData?.toJson()}");

    isLoading.value = false;
  }

  void init(){
    isLoading.value = false;
    vogueResponseOnlyData = null;
  }
}