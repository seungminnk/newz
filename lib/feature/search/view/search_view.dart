import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newz/feature/home/components/keyword_box.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _searchController = TextEditingController();
  final List _keywordList = [];
  final List keyword = ['Text','Text','Text','Text','Text','Text','Text','Text','Text','Text'];
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;
  String _searchText = "";

  @override
  void initState(){
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _focusNode.addListener(() {_onFocusChange();});}


  void _onFocusChange(){
    setState(() {
      isFocus = !isFocus;
    });
  }

  void _unFocus(){
    _focusNode.unfocus();
    _searchController.clear();
  }


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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
            color: Colors.black,),
          title: const Text("검색",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff37474f),),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: SvgPicture.asset("assets/icons/sort.svg"),
            onPressed: () => Navigator.pop(context),)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height:24,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _searchController ,
                    decoration: InputDecoration(
                        prefixIcon:
                            Container(
                              width: 24,
                              height: 24,
                              padding: EdgeInsets.only(right: 20),
                              child: SvgPicture.asset(
                                  "assets/icons/search.svg",),
                            ),
                        hintText: '원하는 기사를 검색해봐요',
                        hintStyle: const TextStyle(
                          fontSize: 14.0,
                          color: Color(0xff121212),
                          fontWeight: FontWeight.w400),
                        suffixIcon: GestureDetector(
                          onTap: _unFocus,
                          child: const Icon(Icons.cancel_outlined),
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(padding: EdgeInsets.only(left:16)),
              Text("지금 사람들이 많이 검색하는 키워드예요",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff37474f),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),

          Expanded(
              child: ListView.builder(
                  itemCount: keyword.length,
                  itemBuilder: (context, index) {
                    return Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.start,
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: KeywordBox(
                          keyword: keyword[index],
                          position: index,
                      ),
                    ),
                      ],
                    );
                  }
              ),
            )

        ],
      ),

    );
  }
}
