import 'package:dio/dio.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_keyword_dto.dart';

class KeywordRadioModel {
  bool isSelected = false;
  final String buttonText;
  final String value;

  KeywordRadioModel(this.isSelected, this.buttonText, this.value);

  KeywordRadioModel.notSelectedTextValueSame(String text) :
      buttonText = text,
      value = text;

  static get keywordBaseUrl => "https://newz.bbear.kr/api/user/keyword/list?userId=";

  static List<KeywordRadioModel> fromVogueKeywordRequest(List<RealTimeVogueResponseOnlyKeywordDto> vogueResponseOnlyKeywordDtoList){
    return vogueResponseOnlyKeywordDtoList.map((keywordModel) {
      return KeywordRadioModel.notSelectedTextValueSame(keywordModel.keyword!);
    }).toList();
  }

  static Future<List> getKeywordListByDio(String id) async {
    List keyWordInstances = [];
    try {
      Response respKL = await Dio().get(keywordBaseUrl + id);
      for (var data in respKL.data) {
        keyWordInstances.add(data);
      }
      return keyWordInstances.toList();
    } catch (e) {
      print(e);
    }
    throw Error();
  }
}