import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_keyword_dto.dart';

class KeywordRadioModel {
  bool isSelected = false;
  final String buttonText;
  final String value;

  KeywordRadioModel(this.isSelected, this.buttonText, this.value);

  KeywordRadioModel.notSelectedTextValueSame(String text) :
      buttonText = text,
      value = text;

  static List<KeywordRadioModel> fromVogueKeywordRequest(List<RealTimeVogueResponseOnlyKeywordDto> vogueResponseOnlyKeywordDtoList){
    return vogueResponseOnlyKeywordDtoList.map((keywordModel) {
      return KeywordRadioModel.notSelectedTextValueSame(keywordModel.keyword!);
    }).toList();
  }
}