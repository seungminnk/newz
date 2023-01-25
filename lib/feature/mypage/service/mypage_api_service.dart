// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'bookmark_api_model.dart';

class ApiService {
  // 북마크 baseUrl
  static const String bookmarkBaseUrl =
      "https://newz.bbear.kr/api/user/bookmark/news?userId=";

  // 북마크 데이터 호출
  static Future<List<BookmarkModel>> getBookmarkListByDio(
      String id, String page) async {
    // 북마크 condition
    String condition = "&page=$page&limit=5";

    List<BookmarkModel> bookmarkInstances = [];
    try {
      Response respBL = await Dio().get(bookmarkBaseUrl + id + condition);
      for (var data in respBL.data['news']) {
        bookmarkInstances.add(BookmarkModel.fromJson(data));
      }
      return bookmarkInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  // 키워드 baseUrl
  static const String keywordBaseUrl =
      "https://newz.bbear.kr/api/user/keyword/list?userId=";

  // 키워드 데이터 호출
  static Future<List> getKeywordListByDio(String id) async {
    List keyWordInstances = [];
    try {
      Response respKL = await Dio().get(keywordBaseUrl + id);
      for (var data in respKL.data) {
        keyWordInstances.add(data);
      }
      return keyWordInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  // 북마크 삭제 API
  static void removeBookmark(String id) async {
    await Dio()
        .post('https://newz.bbear.kr/api/user/bookmark/remove?bookmarkId=$id');
  }

  // 북마크 추가 API
  static void addBookmark(String url) async {
    await Dio().post('https://newz.bbear.kr/api/user/bookmark/add', data: {
      "newsUrl": url,
    });
  }

  // 키워드 삭제 API
  static void removeKeyword(String id, String keyword) async {
    await Dio().post('https://newz.bbear.kr/api/user/keyword/remove', data: {
      "userId": id,
      "keywords": [keyword]
    });
  }

  // 키워드 추가 API
  static void addKeyword(String keyword) async {
    await Dio().post('https://newz.bbear.kr/api/user/keyword/add', data: {
      "keywords": [keyword]
    });
  }
}
