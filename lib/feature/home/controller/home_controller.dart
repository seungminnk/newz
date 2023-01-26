import 'package:get/get.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';

class HomeController extends GetxController {
  List<String> keywordList = [];
  int selectedKeywordIndex = -1;

  @override
  void onInit() {
    super.onInit();
    if(Get.isRegistered<Mypagecontroller>()){
      // TODO 어딘가 다른 컨트롤러에서 가져와야함
      try{
        var mypageController = Get.find<Mypagecontroller>();
        keywordList = mypageController.keywordlist.map((element) => element.toString()).toList();
        update();
      }
      catch(e){
        print(e);
      }
    }
    else {
      keywordList = ['플러터', '테스트', '키워드'];
      update();
    }
  }
}