import 'package:get/get.dart';
import 'package:newz/feature/mypage/bookmark_api_model.dart';
import 'package:newz/feature/mypage/news_api_service.dart';

import 'news_api_model.dart';

class ScrapController extends GetxController {
  final RxBool isLiked = false.obs;
  RxList<BookmarkModel> bookmarklist = <BookmarkModel>[].obs;
  RxList newslist = <NewsModel>[].obs;

  void fetchBookmark(String id) async {
    var items = await ApiService.getBookmarkListByDio(id);
    bookmarklist.assignAll(items);
  }

  void fetchNews(String keyword) async {
    var items = await ApiService.getNewsData(keyword);
    newslist.assignAll(items);
  }

  void scrapButtonClick(String link) async {
    if (isLiked.isTrue) {
      bookmarklist.removeWhere((element) => element.link == link);
    } else {
      // 북마크 추가
    }
  }
}
