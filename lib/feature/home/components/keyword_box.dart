import 'package:flutter/material.dart';

class KeywordBox extends StatelessWidget {
  const KeywordBox({Key? key, required this.keyword, required this.position})
      : super(key: key);

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
          color: Color(0xffECEFF1),
        ),
        child: Text(keyword,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff78909c),
          ),
        ),
      ),
    );
  }
}
