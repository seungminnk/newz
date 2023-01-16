import 'package:get/get.dart';
import 'package:newz/feature/mypage/service/bookmark_api_model.dart';

import '../service/bookmark_api_service.dart';

class Bookmarkcontroller extends GetxController {
  final RxBool isBookmark = false.obs;
  RxList bookmarklist = <BookmarkModel>[].obs;

  void fetchBookmark(String id) async {
    var items = await ApiService.getBookmarkListByDio(id);
    bookmarklist.assignAll(items);
  }

  void keywordSettingButtonClick() {
    if (isBookmark.isTrue) {
      isBookmark(false);
    } else {
      isBookmark(true);
    }
  }

  void removeButtonClick(String id) {
    ApiService.removeBookmark(id);
  }
}
