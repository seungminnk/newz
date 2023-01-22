import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newz/common/component/loading/view/CustomCircularProgressIndicator.dart';
import 'package:newz/common/component/news/view/news_component_view.dart';
import 'package:newz/feature/search/controller/search_controller.dart';
import 'package:newz/feature/search/model/dto/search_response_only_data_dto.dart' as SearchNewsData;

class SearchNewsView extends GetView<SearchController> {
  const SearchNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(() => controller.pagingController.refresh()),
      child: PagedListView<int, SearchNewsData.News>(
        physics: const BouncingScrollPhysics(),
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<SearchNewsData.News>(
          itemBuilder: (context, item, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 8.0),
                child: NewsComponentView(
                  title: item.title,
                  content: item.content,
                  link: item.link,
                  key: Key(index.toString()),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
              child: NewsComponentView(
                title: item.title,
                content: item.content,
                link: item.link,
                key: Key(index.toString()),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CustomCircularProgressIndicator(),
              ),
            );
          }
        ),
      ),
    );
  }
}
