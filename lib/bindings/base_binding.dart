import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/bottom_nav_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavController>(BottomNavController());
  }
}
