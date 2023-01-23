import 'dart:convert';
/// news : [{"title":"길어지는 득점왕 손흥민 부진…'슬럼프인가 쇠퇴기인가'","content":"기사내용 요약 올 시즌 EPL 단 4골뿐…지난 시즌 23골에 한참 못 미쳐 카타르월드컵으로 인한 빡빡한 일정과 안와골절 부상 등 굵직한 변수 영향 30대 접어들면서 기량 저하 가속화 지적도 토트넘 전술 비판도…손흥민 외에 '900억' 히샤를리송도 단 2골 [맨체스터=AP/뉴시스] 토트넘 홋스퍼의 손흥민이 19일(현지시간) 영국 맨체스터의 에티하드 스타디움에서 열린 2022~23시즌 잉글랜드 프리미어리그 맨체스터 시티와의 7라운드 순연 경기 후반 45분 팀의 네 번째 골을 허용한 후 허탈해하고 있다.","link":"https://sports.news.naver.com/news.nhn?oid=003&aid=0011654687"},{"title":"\"손흥민·BTS 제이홉 어쩌나\"…지자체 울린 기재부 황당 실수","content":"━ 윤석열·손흥민·BTS 제이홉도 '고향사랑기부제' 참여   ━ 기재부 \"금투세 2년 유예하는 과정서 실수\"   ━ \"오류 못 잡은 법제처·국회도 문제\"…기재부 \"법 다시 개정\"   ━ 지자체들 \"정부 책임\"…기재부 비판엔 말 아껴   ━ 전북도 \"있을 수 없는 일\"…대구시 \"지켜보겠다\"   ━ 2007년 문국현 대선 공약…관련 법 번번이 무산  \"세액 공제가 안 되면 곤란한 상황이 생길 수밖에 없을 것 같아요.","link":"https://n.news.naver.com/mnews/article/025/0003254789?sid=102"},{"title":"또 '유효슈팅 1회' 손흥민…맨시티전 역전패에 4∼6점대 평점","content":"아쉬워하는 손흥민 [로이터=연합뉴스] 아쉬워하는 손흥민[로이터=연합뉴스] 마스크를 벗은 손흥민 [AP=연합뉴스] 마스크를 벗은 손흥민[AP=연합뉴스] 리그 22호골을 기록한 홀란 [로이터=연합뉴스] 리그 22호골을 기록한 홀란[로이터=연합뉴스] (서울=연합뉴스) 이의진 기자 = 영국 프로축구 프리미어리그(EPL) 토트넘 홋스퍼가 후반에만 네 골을 헌납하며 역전패한 가운데 핵심 공격자원인 손흥민(31)도 현지 매체로부터 아쉬운 평점을 받았다.","link":"https://sports.news.naver.com/news.nhn?oid=001&aid=0013712282"}]
/// total : 522359
/// page : 1

SearchResponseOnlyDataDto searchResponseOnlyDataDtoFromJson(String str) => SearchResponseOnlyDataDto.fromJson(json.decode(str));
String searchResponseOnlyDataDtoToJson(SearchResponseOnlyDataDto data) => json.encode(data.toJson());
class SearchResponseOnlyDataDto {
  SearchResponseOnlyDataDto({
      this.news, 
      this.total, 
      this.page,});

  SearchResponseOnlyDataDto.fromJson(dynamic json) {
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
SearchResponseOnlyDataDto copyWith({  List<News>? news,
  int? total,
  int? page,
}) => SearchResponseOnlyDataDto(  news: news ?? this.news,
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

/// title : "길어지는 득점왕 손흥민 부진…'슬럼프인가 쇠퇴기인가'"
/// content : "기사내용 요약 올 시즌 EPL 단 4골뿐…지난 시즌 23골에 한참 못 미쳐 카타르월드컵으로 인한 빡빡한 일정과 안와골절 부상 등 굵직한 변수 영향 30대 접어들면서 기량 저하 가속화 지적도 토트넘 전술 비판도…손흥민 외에 '900억' 히샤를리송도 단 2골 [맨체스터=AP/뉴시스] 토트넘 홋스퍼의 손흥민이 19일(현지시간) 영국 맨체스터의 에티하드 스타디움에서 열린 2022~23시즌 잉글랜드 프리미어리그 맨체스터 시티와의 7라운드 순연 경기 후반 45분 팀의 네 번째 골을 허용한 후 허탈해하고 있다."
/// link : "https://sports.news.naver.com/news.nhn?oid=003&aid=0011654687"

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