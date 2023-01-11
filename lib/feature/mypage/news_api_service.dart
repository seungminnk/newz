import 'dart:convert';

import 'package:http/http.dart' as http;

import 'news_api_model.dart';

class ApiService {
  static const String baseUrl = "https://newz.bbear.kr/news/list?query=";
  static Future<List<NewsModel>> getNewsData() async {
    List<NewsModel> newsInstances = [];
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> news = jsonDecode(utf8.decode(response.bodyBytes));
      for (var x in news) {
        newsInstances.add(NewsModel.fromJson(x));
      }
      return newsInstances;
    }
    throw Error();
  }
}
