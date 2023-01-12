// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'bookmark_api_model.dart';
import 'news_api_model.dart';

class ApiService {
  // 뉴스 검색 API base data
  static const String newsBaseUrl =
      "https://newz.bbear.kr/api/news/list?query=";
  static const String condition = "&page=1&limit=3";

  // 북마크 baseUrl
  static const String bookmarkBaseUrl =
      "https://newz.bbear.kr/api/user/bookmark/list?id=";

  // 뉴스 검색 API 호출
  static Future<List<NewsModel>> getNewsData(String keyword) async {
    List<NewsModel> newsInstances = [];
    try {
      Response resp = await Dio().get(newsBaseUrl + keyword + condition);
      for (var x in resp.data['news']) {
        newsInstances.add(NewsModel.fromJson(x));
      }
      return newsInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  //뉴스 북마크 리스트 호출 by http
  static Future<List<BookmarkModel>> getBookmarkListByHttp(String id) async {
    List<BookmarkModel> bookmarkInstances = [];
    final url = Uri.parse(bookmarkBaseUrl + id);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> bookmarkData =
          jsonDecode(utf8.decode(response.bodyBytes));
      for (var x in bookmarkData) {
        bookmarkInstances.add(BookmarkModel.fromJson(x));
      }
      return bookmarkInstances;
    }
    throw Error();
  }

  //뉴스 북마크 리스트 호출 by dio
  static Future<List<BookmarkModel>> getBookmarkListByDio(String id) async {
    List<BookmarkModel> bookmarkInstances = [];
    try {
      Response resp = await Dio().get(bookmarkBaseUrl + id);
      for (var x in resp.data) {
        bookmarkInstances.add(BookmarkModel.fromJson(x));
      }
      return bookmarkInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }
}
