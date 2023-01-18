import 'package:flutter/material.dart';
import 'package:newz/common/component/news/view/expand/news_component_exapnd_view.dart';
import 'package:newz/common/component/news/view/summary/news_component_summary_view.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_response_only_data_dto.dart';

class NewsComponentView extends StatefulWidget {
  const NewsComponentView({required this.news, Key? key}) : super(key: key);

  final News news;
  final Color fontColor = const Color.fromARGB(255, 55, 71, 79);

  @override
  State<NewsComponentView> createState() => _NewsComponentViewState();
}

class _NewsComponentViewState extends State<NewsComponentView> {
  bool _isExpanded = false;

  void _onTap() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(30, 11, 15, 53),
              blurRadius: 10,
              offset: Offset(1, 3), // changes position of shadow
            ),
          ],
        ),
        child: _isExpanded
            ? NewsComponentExpandView(news: widget.news, onTap: _onTap)
            : NewsComponentSummaryView(news: widget.news, onTap: _onTap),
      ),
    );
  }
}
