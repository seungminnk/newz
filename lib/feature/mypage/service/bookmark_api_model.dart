class BookmarkModel {
  final String link, title, content;
  final int bookmarkId;

  BookmarkModel.fromJson(Map<dynamic, dynamic> json)
      : bookmarkId = json['bookmarkId'],
        link = json['link'],
        title = json['title'],
        content = json['content'];
}
