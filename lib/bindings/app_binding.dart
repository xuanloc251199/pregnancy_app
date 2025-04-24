import 'package:get/get.dart';
import 'package:pregnancy_app/bindings/base_binding.dart';
import 'package:pregnancy_app/controllers/appointment_controller.dart';
import 'package:pregnancy_app/controllers/calendar_controller.dart';
import 'package:pregnancy_app/controllers/side_bar_controller.dart';
import 'auth_binding.dart';
// import thêm các binding khác nếu cần

class AppBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    BaseBinding().dependencies();
    Get.put<SidebarController>(SidebarController(), permanent: true);
    Get.put<CalendarController>(CalendarController(), permanent: true);
    Get.put<AppointmentController>(AppointmentController(), permanent: true);
  }
}
