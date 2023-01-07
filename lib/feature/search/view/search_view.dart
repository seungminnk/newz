import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final List _keywordList = [];
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  _SearchViewState () {
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        elevation: 0.0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),),
      ),
      body: Center(
        child: Column(
        children: [
          const SizedBox(height:24,),
          Text("키워드 선택",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,),
          ),
          const SizedBox(height:10,),
          Text("다른 흥미로운\n키워드를 선택해보세요",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height:24,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController ,
                    decoration: const InputDecoration(

                      hintText: '원하는 키워드를 적어보아요',
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
            Container(
              height: 55,
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print(_searchController.text);
                  if (_searchController.text.isNotEmpty) {
                    setState(() {
                      _keywordList.add;
                      _searchController.clear();
                    });
                  }
                }
              ),
            )],
            ),
          ),
        ],
      ),
      )
    );
  }
}
