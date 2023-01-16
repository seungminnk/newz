// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'bookmark_api_model.dart';

class ApiService {
  // 북마크 baseUrl
  static const String bookmarkBaseUrl =
      "https://newz.bbear.kr/api/user/bookmark/news?userId=";

  // 북마크 condition
  static const String condition = "&page=1&limit=3";

  // 뉴스 검색 API 호출
  // static Future<List<NewsModel>> getNewsData(String keyword) async {
  //   List<NewsModel> newsInstances = [];
  //   try {
  //     Response resp = await Dio().get(newsBaseUrl + keyword + condition);
  //     for (var x in resp.data['news']) {
  //       newsInstances.add(NewsModel.fromJson(x));
  //     }
  //     return newsInstances;
  //   } catch (e) {
  //     print(e);
  //   }
  //   throw Error();
  // }

  //뉴스 북마크 리스트 호출 by http
  // static Future<List<BookmarkModel>> getBookmarkListByHttp(String id) async {
  //   List<BookmarkModel> bookmarkInstances = [];
  //   final url = Uri.parse(bookmarkBaseUrl + id);
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final List<dynamic> bookmarkData =
  //         jsonDecode(utf8.decode(response.bodyBytes));
  //     for (var x in bookmarkData) {
  //       bookmarkInstances.add(BookmarkModel.fromJson(x));
  //     }
  //     return bookmarkInstances;
  //   }
  //   throw Error();
  // }

  // 뉴스 북마크 리스트 호출 by dio
  static Future<List<BookmarkModel>> getBookmarkListByDio(String id) async {
    List<BookmarkModel> bookmarkInstances = [];
    try {
      Response resp = await Dio().get(bookmarkBaseUrl + id + condition);
      for (var data in resp.data['news']) {
        bookmarkInstances.add(BookmarkModel.fromJson(data));
      }
      return bookmarkInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  static void removeBookmark(String id) async {
    await Dio()
        .patch("https://newz.bbear.kr/api/user/bookmark/remove?bookmarkId=$id");
  }
}
