import 'dart:convert';
/// news : [{"title":"기로에 선 조규성, 유럽 무산 '리스크'까지 감수할까","content":"/AFPBBNews=뉴스1 대한민국 축구대표팀 공격수 조규성이 지난 11월 28일 가나와의 카타르 월드컵 조별리그 2차전에서 골을 넣은 뒤 기뻐하고 있다.\n/AFPBBNews=뉴스1 대한민국 축구대표팀 공격수 조규성이 지난 11월 28일 가나와의 카타르 월드컵 조별리그 2차전에서 골을 넣은 뒤 기뻐하고 있다.","link":"https://sports.news.naver.com/news.nhn?oid=108&aid=0003121443"},{"title":"'유럽행' 원하던 조규성 일단 전북 잔류, 여름까지 K리그에 남는다","content":"김상식 전북 감독은 15일 스포츠조선과의 전화통화에서 \"조규성이 마음을 정리하고 전북에 남기로 했다.\n박 테크니컬 디렉터도 조규성이 유럽 진출을 원한다면 겨울보다 여름이 낫다고 조언했다고 한다.\n때문에 조규성이 적응하기에는 겨울보다 시장 규모가 더 큰 여름이 낫다고 설득한 것으로 알렸다.","link":"https://sports.news.naver.com/news.nhn?oid=076&aid=0003960784"},{"title":"조규성, 한국 잔류하나…여름 이적에 무게","content":"ⓒ 데일리안 홍금표 기자 전북 잔류에 무게가 쏠리고 있는 조규성.\nⓒ 한국프로축구연맹 전북 잔류에 무게가 쏠리고 있는 조규성.\nⓒ 한국프로축구연맹 [데일리안 = 김평호 기자] 국가대표 공격수 조규성(전북)의 유럽 진출 꿈은 잠시 미뤄지는 것일까.\n다만 선수 입장에서는 기회가 왔을 때 나가고 싶을 수밖에 없다.","link":"https://sports.news.naver.com/news.nhn?oid=119&aid=0002675504"}]
/// total : 34438
/// page : 1

RealTimeVogueResponseOnlyDataDto realTimeVogueResponseOnlyDataDtoFromJson(String str) => RealTimeVogueResponseOnlyDataDto.fromJson(json.decode(str));
String realTimeVogueResponseOnlyDataDtoToJson(RealTimeVogueResponseOnlyDataDto data) => json.encode(data.toJson());
class RealTimeVogueResponseOnlyDataDto {
  RealTimeVogueResponseOnlyDataDto({
      this.news, 
      this.total, 
      this.page,});

  RealTimeVogueResponseOnlyDataDto.fromJson(dynamic json) {
    if (json['news'] != null) {
      news = [];
      json['news'].forEach((v) {
        news?.add(News.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
  }
  List<News>? news;
  int? total;
  int? page;
RealTimeVogueResponseOnlyDataDto copyWith({  List<News>? news,
  int? total,
  int? page,
}) => RealTimeVogueResponseOnlyDataDto(  news: news ?? this.news,
  total: total ?? this.total,
  page: page ?? this.page,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (news != null) {
      map['news'] = news?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['page'] = page;
    return map;
  }

}

/// title : "기로에 선 조규성, 유럽 무산 '리스크'까지 감수할까"
/// content : "/AFPBBNews=뉴스1 대한민국 축구대표팀 공격수 조규성이 지난 11월 28일 가나와의 카타르 월드컵 조별리그 2차전에서 골을 넣은 뒤 기뻐하고 있다.\n/AFPBBNews=뉴스1 대한민국 축구대표팀 공격수 조규성이 지난 11월 28일 가나와의 카타르 월드컵 조별리그 2차전에서 골을 넣은 뒤 기뻐하고 있다."
/// link : "https://sports.news.naver.com/news.nhn?oid=108&aid=0003121443"

News newsFromJson(String str) => News.fromJson(json.decode(str));
String newsToJson(News data) => json.encode(data.toJson());
class News {
  News({
      this.title, 
      this.content, 
      this.link,});

  News.fromJson(dynamic json) {
    title = json['title'];
    content = json['content'];
    link = json['link'];
  }
  String? title;
  String? content;
  String? link;
News copyWith({  String? title,
  String? content,
  String? link,
}) => News(  title: title ?? this.title,
  content: content ?? this.content,
  link: link ?? this.link,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['content'] = content;
    map['link'] = link;
    return map;
  }

}