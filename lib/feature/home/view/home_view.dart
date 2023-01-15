import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newz/feature/home/components/keyword_box.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List keyword = ['Text','Text','Text','Text','Text','Text','Text','Text','Text'];
  final List<String> title = <String>['title','title'];
  final List<String> content = <String>['content','content'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:
        Container(
          child:
          SvgPicture.asset("assets/icons/logo.svg",
            width: 88,
            height: 40,
          ),
        ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: [
        IconButton(icon: SvgPicture.asset("assets/icons/sort.svg"),
          onPressed: () => Navigator.pop(context),)
      ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("길동님의 관련 기사를 가져왔어요!",
              style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: 20,
                color: Color(0xff37474f),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18,),
          SizedBox(height: 35,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: keyword.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  child: KeywordBox(
                    keyword: keyword[index],
                    position: index,
                  ),
                );
              }
              ),
          ),
          Expanded(child:
          ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(8),
            itemCount: title.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 4.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('${title[index]}'),
                      subtitle: Text('${content[index]}'),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ))

        ],
      ),
    );
  }
}
