import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/controller/real_time_vogue_controller.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_base_dto.dart';

class RealTimeVogueView extends GetView<RealTimeVogueController> {
  const RealTimeVogueView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('인기 페이지 테스트'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.mockRealTimeVogueList.length,
          itemBuilder: (context, index) {

            RealTimeVogueBaseDto realTimeVogueBaseDto = controller.mockRealTimeVogueList[index];

            // if(index == 2){
            //   realTimeVogueBaseDto.content = "긴 기사 내용을 만들기 위해서 일부러 길게 작성하고 있습니다. 이해 부탁드립니다. 어떻게 되는지 테스트 하는 거니까요 ㅎㅎ";
            // }

            return _vogueNewsView(realTimeVogueBaseDto);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 5,
            );
          },
        ),
      ),
    );
  }

  Widget _vogueNewsView(RealTimeVogueBaseDto realTimeVogueBaseDto){
    return Column(
      children: [
        _vogueNewsKeyword(realTimeVogueBaseDto),
        const SizedBox(height: 10),
        _vogueNewsCardView(realTimeVogueBaseDto)
      ],
    );
  }

  Widget _vogueNewsKeyword(RealTimeVogueBaseDto realTimeVogueBaseDto){
    return Container(
      width: double.infinity,
      child: Text(
        "${realTimeVogueBaseDto.rank}. ${realTimeVogueBaseDto.keyword}",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      )
    );
  }

  Widget _vogueNewsCardView(RealTimeVogueBaseDto realTimeVogueBaseDto) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 239, 241),
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                realTimeVogueBaseDto.imageUrl ?? "assets/images/no_image.png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                color: Color.fromARGB(255, 217, 217, 217),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    realTimeVogueBaseDto.title,
                    style: const TextStyle(
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    realTimeVogueBaseDto.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
