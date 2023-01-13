import 'package:flutter/material.dart';
import 'package:newz/common/component/keyword/model/keyword_radio_model.dart';
import 'package:newz/common/component/keyword/view/keyword_button_view.dart';

class KeywordCustomButtonGroupView extends StatefulWidget {
  const KeywordCustomButtonGroupView({Key? key}) : super(key: key);

  @override
  State<KeywordCustomButtonGroupView> createState() =>
      _KeywordCustomButtonGroupViewState();
}

class _KeywordCustomButtonGroupViewState
    extends State<KeywordCustomButtonGroupView> {
  List<KeywordRadioModel> sampleData = <KeywordRadioModel>[];
  String groupValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(KeywordRadioModel(false, 'AAAAA', 'April 18'));
    sampleData.add(KeywordRadioModel(false, 'BBBBB', 'April 17'));
    sampleData.add(KeywordRadioModel(false, 'CCCCC', 'April 16'));
    sampleData.add(KeywordRadioModel(false, 'DDDDD', 'April 15'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListItem"),
      ),
      body: Wrap(
        children: [
          InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                for (var element in sampleData) {
                  element.isSelected = false;
                }
                sampleData[0].isSelected = true;
              });
            },
            child: KeywordButtonView(sampleData[0]),
          ),
          InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                for (var element in sampleData) {
                  element.isSelected = false;
                }
                sampleData[1].isSelected = true;
              });
            },
            child: KeywordButtonView(sampleData[1]),
          ),
          InkWell(
            //highlightColor: Colors.red,
            borderRadius: BorderRadius.circular(8.0),
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                for (var element in sampleData) {
                  element.isSelected = false;
                }
                sampleData[2].isSelected = true;
              });
            },
            child: KeywordButtonView(sampleData[2]),
          ),
          InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.blueAccent,
            onTap: () {
              setState(() {
                for (var element in sampleData) {
                  element.isSelected = false;
                }
                sampleData[3].isSelected = true;
              });
            },
            child: KeywordButtonView(sampleData[3]),
          ),
        ],
      ),
      // body: ListView.builder(
      // itemCount: sampleData.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return InkWell(
      //       //highlightColor: Colors.red,
      //       splashColor: Colors.blueAccent,
      //       onTap: () {
      //         setState(() {
      //           for (var element in sampleData) {
      //             element.isSelected = false;
      //           }
      //           sampleData[index].isSelected = true;
      //         });
      //       },
      //       child: KeywordButtonView(sampleData[index]),
      //     );
      //   },
      // ),
    );
  }
}
