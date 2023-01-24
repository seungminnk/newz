import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/search/model/dto/search_page_model.dart';
import 'package:newz/feature/search/model/dto/search_response_only_data_dto.dart' as SearchNewsData;

class SearchResultController extends GetxController{

  final PagingController<int, SearchNewsData.News> pagingController = PagingController(firstPageKey: 1);

  final SearchPageModel searchPageModel = SearchPageModel();

  void requestSearchData() async{

    searchPageModel.isLoading(true);

    var response = await DioManager.instance.dio.get(
      "/news/list",
      queryParameters: {
        'query': searchPageModel.searchKeyword.value,
        'page': searchPageModel.page,
        'limit': searchPageModel.size,
      }
    );

    SearchNewsData.SearchResponseOnlyDataDto searchResponseOnlyDataDto = SearchNewsData.SearchResponseOnlyDataDto.fromJson(response.data);

    searchPageModel.isLastPage = searchResponseOnlyDataDto.news!.length < searchPageModel.size;

    print("검색 페이지 데이터 확인 : ${searchPageModel.toString()}");

    if(searchPageModel.isLastPage){
      pagingController.appendLastPage(searchResponseOnlyDataDto.news!);
    }
    else{
      pagingController.appendPage(searchResponseOnlyDataDto.news!, searchPageModel.page);
      searchPageModel.page += 1;
    }

    searchPageModel.isLoading(false);
  }

  void requestSearchKeywordDataToServer(){
    pagingController.removePageRequestListener(pagingControllerListener);
    pagingController.addPageRequestListener(pagingControllerListener);
    searchPageModel.page = 1;
    pagingController.refresh();
  }

  void pagingControllerListener(pageKey){
    requestSearchData();
  }

  @override
  void onInit() {
    super.onInit();
    searchPageModel.searchKeyword.listen((changedKeyword) {
      if(changedKeyword.isNotEmpty){
        requestSearchKeywordDataToServer();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}