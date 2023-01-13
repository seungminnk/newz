import 'dart:convert';
/// keyword : "카트라이더: 드리프트"

RealTimeVogueResponseOnlyKeywordDto realTimeVogueResponseOnlyKeywordDtoFromJson(String str) => RealTimeVogueResponseOnlyKeywordDto.fromJson(json.decode(str));
String realTimeVogueResponseOnlyKeywordDtoToJson(RealTimeVogueResponseOnlyKeywordDto data) => json.encode(data.toJson());
class RealTimeVogueResponseOnlyKeywordDto {
  RealTimeVogueResponseOnlyKeywordDto({
      this.keyword,});

  RealTimeVogueResponseOnlyKeywordDto.fromJson(dynamic json) {
    keyword = json['keyword'];
  }
  String? keyword;
RealTimeVogueResponseOnlyKeywordDto copyWith({  String? keyword,
}) => RealTimeVogueResponseOnlyKeywordDto(  keyword: keyword ?? this.keyword,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['keyword'] = keyword;
    return map;
  }

}