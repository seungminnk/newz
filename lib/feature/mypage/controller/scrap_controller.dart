import 'package:get/get.dart';
import 'package:newz/feature/mypage/service/bookmark_api_model.dart';
import 'package:newz/feature/mypage/service/news_api_service.dart';

import '../service/news_api_model.dart';

class ScrapController extends GetxController {
  final RxBool isLiked = false.obs;
  RxList bookmarklist = <BookmarkModelTest>[].obs;
  RxList newslist = <NewsModel>[].obs;

  // void fetchBookmark(String id) async {
  //   var items = await ApiService.getBookmarkListByDio(id);
  //   bookmarklist.assignAll(items);
  // }

  void fetchNews(String keyword) async {
    var items = await ApiService.getNewsData(keyword);
    newslist.assignAll(items);
  }

  void scrapButtonClick(
      {required String title,
      required String content,
      required String link}) async {
    if (isLiked.isTrue) {
      bookmarklist.removeWhere((element) => element.link == link);
      isLiked(false);
    } else {
      bookmarklist
          .add(BookmarkModelTest(title: title, content: content, link: link));
      isLiked(true);
      // 북마크 추가
    }
  }
}
