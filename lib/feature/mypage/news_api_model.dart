class NewsModel {
  final String link, title, content;

  NewsModel.fromJson(Map<String, dynamic> json)
      : link = json['link'],
        title = json['title'],
        content = json['content'];
}
