import 'package:get/get.dart';
import 'package:pregnancy_app/bindings/base_binding.dart';
import 'package:pregnancy_app/controllers/appointment_controller.dart';
import 'package:pregnancy_app/controllers/calendar_controller.dart';
import 'package:pregnancy_app/controllers/side_bar_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/bottom_nav_controller.dart';
import '../controllers/note_controller.dart';
import '../controllers/pregnancy_info_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/weight_controller.dart';
import 'auth_binding.dart';
// import thêm các binding khác nếu cần

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<BottomNavController>(BottomNavController(), permanent: true);
    Get.put<SidebarController>(SidebarController(), permanent: true);
    Get.put<CalendarController>(CalendarController(), permanent: true);
    Get.put<AppointmentController>(AppointmentController(), permanent: true);
    Get.put<NoteController>(NoteController(), permanent: true);
    Get.put<ProfileController>(ProfileController(), permanent: true);
    Get.put<PregnancyInfoController>(PregnancyInfoController(),
        permanent: true);
    // Get.put<WeightController>(WeightController(), permanent: true);
  }
}
