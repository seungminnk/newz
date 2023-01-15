import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';

class KeywordButtonShapeView extends StatelessWidget {

  final KeywordRadioModel _item;

  final Color _baseTextColor = const Color.fromARGB(255, 120, 144, 156);
  final Color _clickedTextColor = const Color.fromARGB(255, 255, 255, 255);

  final Color _baseButtonColor = const Color.fromARGB(255, 236, 239, 241);
  final Color _clickedButtonColor = const Color.fromARGB(255, 140, 158, 255);

  const KeywordButtonShapeView(this._item, {
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: _item.isSelected ? _clickedButtonColor : _baseButtonColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Align(
        widthFactor: 1.0,
        alignment: Alignment.centerLeft,
        child: Text(
          _item.buttonText,
          style: TextStyle(
              color: _item.isSelected ? _clickedTextColor : _baseTextColor),
        ),
      ),
    );

  }
}


