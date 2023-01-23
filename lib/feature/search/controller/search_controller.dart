import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newz/config/network/dio_manager.dart';
import 'package:newz/feature/search/model/dto/search_page_model.dart';
import 'package:newz/feature/search/model/dto/search_response_only_data_dto.dart' as SearchNewsData;

class SearchController extends GetxController{

  final PagingController<int, SearchNewsData.News> pagingController = PagingController(firstPageKey: 1);
  final SearchPageModel _searchPageModel = SearchPageModel();

  void requestSearchData() async{

    _searchPageModel.isLoading = true;

    var response = await DioManager.instance.dio.get(
      "/news/list",
      queryParameters: {
        'query': '손흥민',
        'page': _searchPageModel.page,
        'limit': _searchPageModel.size,
      }
    );

    SearchNewsData.SearchResponseOnlyDataDto searchResponseOnlyDataDto = SearchNewsData.SearchResponseOnlyDataDto.fromJson(response.data);

    _searchPageModel.isLastPage = searchResponseOnlyDataDto.news!.length < _searchPageModel.size;

    if(_searchPageModel.isLastPage){
      pagingController.appendLastPage(searchResponseOnlyDataDto.news ?? []);
    }
    else{
      pagingController.appendPage(searchResponseOnlyDataDto.news!, _searchPageModel.page);
      _searchPageModel.page += 1;
    }

    print("검색 페이지 데이터 확인 : ${_searchPageModel.toString()}");

    _searchPageModel.isLoading = false;
  }

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      requestSearchData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}