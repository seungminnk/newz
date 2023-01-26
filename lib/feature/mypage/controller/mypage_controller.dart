import 'package:get/get.dart';
import 'package:newz/feature/mypage/service/bookmark_api_model.dart';

import '../service/mypage_api_service.dart';

class Mypagecontroller extends GetxController {
  final RxBool changeKeyword = false.obs;
  final RxBool isKeywordLoading = false.obs;
  final RxBool isBookmarkLoading = false.obs;
  // 무한스크롤 데이터 감지
  final RxBool hasData = true.obs;

  RxList bookmarklist = <BookmarkModel>[].obs;
  RxList keywordlist = [].obs;

  // 북마크 호출 데이터 Rx화 및 loading bool set, 무산스크롤 데이터 감지
  void fetchBookmark(String page) async {
    var items = await ApiService.getBookmarkListByDio(page);
    if (items.isNotEmpty) {
      hasData(true);
      isBookmarkLoading(true);
    } else {
      hasData(false);
    }
    bookmarklist.addAll(items);
  }

  // 마이페이지 이동시 최초 1회 데이터 호출용
  void resetFetchBookmark(String id) async {
    bookmarklist.clear();
    isBookmarkLoading(false);

    fetchBookmark('1');
  }

  // 키워드 호출 데이터 Rx화 및 loading bool set
  void fetchKeyword() async {
    var items = await ApiService.getKeywordListByDio();
    if (items.isNotEmpty) {
      isKeywordLoading(true);
    }
    keywordlist.assignAll(items);
  }

  // 키워드 세팅 버튼 클릭 함수
  void keywordSettingButtonClick() {
    if (changeKeyword.isTrue) {
      changeKeyword(false);
    } else {
      changeKeyword(true);
    }
  }

  // 키워드 삭제 아이콘 클릭 함수
  void keywordRemoveBtn(String id, String keyword) {
    ApiService.removeKeyword(id, keyword);
  }

  // 북마크 삭제 아이콘 클릭 함수
  void bookmarkRemoveBtn(String id) {
    ApiService.removeBookmark(id);
  }

  // 웹뷰 페이지 내 북마크 버튼 함수
  void webViewScapBtn(String url) {}
}
