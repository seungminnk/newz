class RealTimeVogueBaseDto{

  int rank;
  String title;
  String content;
  String link;
  String? imageUrl;
  DateTime pubDate;

  RealTimeVogueBaseDto(this.rank, this.title, this.content, this.link, this.pubDate);

  static RealTimeVogueBaseDto generateMock(){
    return RealTimeVogueBaseDto(1, "타이틀 입니다.", "기사 내용 입니다.", "https://www.naver.com", DateTime.now());
  }

  static List<RealTimeVogueBaseDto> generateMockList(int size){
    return List.filled(size, generateMock(), growable: true);
  }
}