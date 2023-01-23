import 'package:get/get.dart';
import 'package:newz/feature/mypage/service/bookmark_api_model.dart';

import '../service/mypage_api_service.dart';

class Mypagecontroller extends GetxController {
  final RxBool changeKeyword = false.obs;
  final RxBool isKeywordLoading = false.obs;
  final RxBool isBookmarkLoading = false.obs;
  RxList bookmarklist = <BookmarkModel>[].obs;
  RxList keywordlist = [].obs;

  // 북마크 호출 데이터 Rx화 및 loading bool set
  void fetchBookmark(String id, String page) async {
    var items = await ApiService.getBookmarkListByDio(id, page);
    if (items.isNotEmpty) {
      isBookmarkLoading(true);
    }
    bookmarklist.assignAll(items);
  }

  // 키워드 호출 데이터 Rx화 및 loading bool set
  void fetchKeyword(String id) async {
    var items = await ApiService.getKeywordListByDio(id);
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
    ApiService.removeSetKeyword(id, keyword);
  }

  // 북마크 삭제 아이콘 클릭 함수
  void bookmarkRemoveBtn(String id) {
    ApiService.removeBookmark(id);
  }
}
