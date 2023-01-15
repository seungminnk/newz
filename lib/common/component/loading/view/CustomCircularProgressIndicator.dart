import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({
    this.width = 20.0,
    this.height = 20.0,
    Key? key
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        height: height,
        child: const CircularProgressIndicator(
          backgroundColor: Color.fromARGB(255, 197, 202, 233),
          color: Color.fromARGB(255, 63, 81, 181),
        )
    );
  }
}
