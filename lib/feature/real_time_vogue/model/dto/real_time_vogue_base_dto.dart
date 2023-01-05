class RealTimeVogueBaseDto{

  int rank;
  String keyword;
  String title;
  String content;
  String link;
  String? imageUrl;
  DateTime pubDate;

  RealTimeVogueBaseDto(this.rank, this.keyword, this.title, this.content, this.link, this.pubDate);

  static RealTimeVogueBaseDto generateMock(int rank){
    return RealTimeVogueBaseDto(rank, "인기단어", "타이틀 입니다.", "기사 내용 입니다.", "https://www.naver.com", DateTime.now());
  }

  static List<RealTimeVogueBaseDto> generateMockList(int size){

    List<RealTimeVogueBaseDto> mockList = List.empty(growable: true);

    for(int rank=1; rank<=size; rank++){

      var mockData = generateMock(rank);

      if(rank % 2 == 0){
        mockData.content = "긴 기사 내용을 만들기 위해서 일부러 길게 작성하고 있습니다. 이해 부탁드립니다. 어떻게 되는지 테스트 하는 거니까요 ㅎㅎ";
      }

      mockList.add(mockData);
    }

    return mockList;
  }
}