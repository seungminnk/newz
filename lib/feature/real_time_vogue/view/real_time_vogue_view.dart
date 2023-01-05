import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_controller.dart';

class RealTimeVogueView extends GetView<RealTimeVogueController> {
  const RealTimeVogueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _vogueNewsView(){
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(15.0),)
      ),

    );
  }
}
