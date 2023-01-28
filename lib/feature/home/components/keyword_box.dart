import 'package:flutter/material.dart';

class KeywordBox extends StatelessWidget {
  const KeywordBox({Key? key, required this.keyword, required this.position, required this.selected})
      : super(key: key);

  final bool selected;
  final String keyword;
  final int position;

  @override
  Widget build(BuildContext context) {
    var paddingValue = position == 0 ? 20.0 : 8.0;
    return Padding(
      padding: EdgeInsets.only(left: paddingValue),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: selected ? const Color(0xFF3F51B5) : const Color(0xFF37474F),
            width: 1.0,
          ),
          color: Color(selected ? 0xFF3F51B5 : 0xFFFFFFFF),
        ),
        child: Text(keyword,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Color(selected ? 0xFFFFFFFF : 0xFF37474F),
          ),
        ),
      ),
    );
  }
}
