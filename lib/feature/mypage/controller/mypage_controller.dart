import 'package:get/get.dart';
import 'package:newz/feature/mypage/service/bookmark_api_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/mypage_api_service.dart';

class Mypagecontroller extends GetxController {
  final RxBool changeKeyword = false.obs;
  final RxBool isKeywordLoading = false.obs;
  final RxBool isBookmarkLoading = false.obs;
  // 무한스크롤 데이터 감지
  final RxBool hasData = true.obs;

  final RxString userName = "".obs;
  final RxString userEmail = "".obs;
  final RxInt userId = 0.obs;

  RxList bookmarklist = <BookmarkModel>[].obs;
  RxList keywordlist = [].obs;

  void fetchUserdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName(prefs.getString("userName"));
    userEmail(prefs.getString("userEmail"));
    userId(prefs.getInt("userId"));
  }

  // 북마크 호출 데이터 Rx화 및 loading bool set, 무산스크롤 데이터 감지
  void fetchBookmark(String page) async {
    isBookmarkLoading(true);
    var items = await ApiService.getBookmarkListByDio(page);
    if (items.isNotEmpty) {
      hasData(true);
    } else {
      hasData(false);
    }
    bookmarklist.addAll(items);
    isBookmarkLoading(false);
  }

  // 마이페이지 이동시 최초 1회 데이터 호출용
  void resetFetchBookmark(String id) async {
    bookmarklist.clear();
    // isBookmarkLoading(false);

    fetchBookmark('1');
  }

  // 키워드 호출 데이터 Rx화 및 loading bool set
  Future fetchKeyword() async {
    // Future.delayed(const Duration(seconds: 1), () async {
      var items = await ApiService.getKeywordListByDio();
      if (items.isNotEmpty) {
        isKeywordLoading(true);
      }
      keywordlist.assignAll(items);
    // });
  }

  // 키워드 세팅 버튼 클릭 함수
  void keywordSettingButtonClick() {
    if (changeKeyword.isTrue) {
      changeKeyword(false);
    } else {
      changeKeyword(true);
    }
    fetchKeyword();
  }

  // 키워드 삭제 아이콘 클릭 함수
  void keywordRemoveBtn(String keyword) {
    ApiService.removeKeyword(keyword);
  }

  // 북마크 삭제 아이콘 클릭 함수
  void bookmarkRemoveBtn(String url) {
    ApiService.removeBookmark(url);
  }

  // 웹뷰 페이지 내 북마크 버튼 함수
  void webViewScrapBtn(String url) {
    ApiService.addBookmark(url);
  }
}
