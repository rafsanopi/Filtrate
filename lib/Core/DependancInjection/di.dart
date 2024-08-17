import 'package:filtrate/controller/admob_controller.dart';
import 'package:filtrate/controller/chat_gpt_controller.dart';
import 'package:filtrate/controller/home_controller.dart';
import 'package:filtrate/controller/filter_controller.dart';
import 'package:filtrate/controller/search_controller.dart';
import 'package:get/get.dart';

class DependancyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FilterController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => MySearchController(), fenix: true);
    Get.lazyPut(() => ChatGPTController(), fenix: true);
    Get.lazyPut(() => AdMobController(), fenix: true);
  }
}
