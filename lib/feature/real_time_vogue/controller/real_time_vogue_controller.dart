import 'package:get/get.dart';
import 'package:newz/feature/real_time_vogue/model/dto/real_time_vogue_base_dto.dart';

class RealTimeVogueController extends GetxController{
  List<RealTimeVogueBaseDto> mockRealTimeVogueList = RealTimeVogueBaseDto.generateMockList(10);
}