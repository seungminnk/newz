import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("HOME"),
    );
    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(56),
    //     child: AppBar(title: Text('홈바입니다.'),),
    //   ),
    //   body: Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     child: Center(
    //       child: Text("테스트 페이지이죠."),
    //     ),
    //   ),
    // );
  }
}
