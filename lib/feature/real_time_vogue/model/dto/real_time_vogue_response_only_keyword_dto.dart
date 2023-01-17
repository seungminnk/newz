/// keyword : "연말정산 간소화"

class RealTimeVogueResponseOnlyKeywordDto {
  RealTimeVogueResponseOnlyKeywordDto({
    this.keyword,
  });

  RealTimeVogueResponseOnlyKeywordDto.fromJson(dynamic json) {
    keyword = json['keyword'];
  }

  String? keyword;

  RealTimeVogueResponseOnlyKeywordDto copyWith({
    String? keyword,
  }) =>
      RealTimeVogueResponseOnlyKeywordDto(
        keyword: keyword ?? this.keyword,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['keyword'] = keyword;
    return map;
  }
}
