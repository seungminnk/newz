// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bookmark_api_model.dart';

class ApiService {
  // 북마크 데이터 호출
  static Future<List<BookmarkModel>> getBookmarkListByDio(String page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    List<BookmarkModel> bookmarkInstances = [];
    try {
      Response respBL = await dio.get(
        "/user/bookmark/news",
        queryParameters: {
          'page': page,
          'limit': 5,
        },
      );
      for (var data in respBL.data['news']) {
        bookmarkInstances.add(BookmarkModel.fromJson(data));
      }
      return bookmarkInstances;
    } catch (e) {
      print(e);
    }
    throw Error();
  }

  // 키워드 데이터 호출
  static Future<List> getKeywordListByDio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    List keyWordInstances = [];
    try {
      Response respKL = await dio.get("/user/keyword/list");
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
  static void removeBookmark(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    try {
      await dio.post(
        "/user/bookmark/remove",
        data: {
          "newsUrl": url,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 북마크 추가 API
  static void addBookmark(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    try {
      await dio.post(
        "/user/bookmark/add",
        data: {
          "newsUrl": url,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 키워드 삭제 API
  static void removeKeyword(String id, String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    try {
      await dio.post(
        "/user/keyword/remove",
        data: {
          "keywords": [keyword],
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // 키워드 추가 API
  static void addKeyword(String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString("accessToken");
    var dio = DioManager.instance.dio;
    dio.options.headers = {'x-newz-access-token': accessToken};
    try {
      await dio.post(
        "/user/keyword/add",
        data: {
          "keywords": [keyword],
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
