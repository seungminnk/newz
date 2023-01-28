import 'package:get/get.dart';
import 'package:newz/feature/mypage/controller/mypage_controller.dart';

class HomeController extends GetxController {
  List<String> keywordList = ["플러터"];
  int selectedKeywordIndex = 0;
  bool loaded = false;

  changeIndex(int page) {
    selectedKeywordIndex = page;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    load();
  }

  load() async {
    if(Get.isRegistered<Mypagecontroller>()){
      // TODO 어딘가 다른 컨트롤러에서 가져와야함
      try{
        var mypageController = Get.find<Mypagecontroller>();
        await mypageController.fetchKeyword();
        keywordList = mypageController.keywordlist.map((element) => element.toString()).toList();
        loaded = true;
        update();
      }
      catch(e){
        print(e);
      }
    }
    else {
      var mypageController = Get.put(Mypagecontroller());
      await mypageController.fetchKeyword();
      keywordList = mypageController.keywordlist.map((element) => element.toString()).toList();
      loaded = true;
      update();
      // keywordList = ['플러터', '테스트', '키워드'];
      // update();
    }
  }
}