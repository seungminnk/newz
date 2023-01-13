class BookmarkModel {
  final String link, title, content;
  final int bookmarkId;

  BookmarkModel.fromJson(Map<dynamic, dynamic> json, String link, String title)
      : bookmarkId = json['bookmarkId'],
        link = json['link'],
        title = json['title'],
        content = json['content'];
}

class BookmarkModelTest {
  final String link, title, content;

  BookmarkModelTest(
      {required this.title, required this.content, required this.link});

  BookmarkModelTest.fromJson(Map<dynamic, dynamic> json)
      : link = json['link'],
        title = json['title'],
        content = json['content'];
}
