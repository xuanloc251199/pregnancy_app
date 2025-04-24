import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/auth_controller.dart';
import 'package:pregnancy_app/controllers/bottom_nav_controller.dart';
import 'package:pregnancy_app/controllers/calendar_controller.dart';
import 'package:pregnancy_app/controllers/category_controller.dart';
import 'package:pregnancy_app/controllers/edit_profile_controller.dart';
import 'package:pregnancy_app/controllers/event_controller.dart';
import 'package:pregnancy_app/controllers/face_scan_controller.dart';
import 'package:pregnancy_app/controllers/face_verify_controller.dart';
import 'package:pregnancy_app/controllers/profile_controller.dart';
import 'package:pregnancy_app/controllers/qr_scan_controller.dart';
import 'package:pregnancy_app/controllers/side_bar_controller.dart';
import 'package:pregnancy_app/controllers/sign_in_controller.dart';
import 'package:pregnancy_app/controllers/sign_out_controller.dart';
import 'package:pregnancy_app/controllers/user_controller.dart';
import 'package:pregnancy_app/repositories/category_repository.dart';
import 'package:pregnancy_app/repositories/class_repository.dart';
import 'package:pregnancy_app/repositories/event_repository.dart';
import 'package:pregnancy_app/repositories/faculty_repository.dart';
import 'package:pregnancy_app/repositories/profile_repository.dart';
import 'package:pregnancy_app/repositories/unit_reponsitory.dart';
import 'package:pregnancy_app/repositories/user_repository.dart';
import 'package:pregnancy_app/services/api_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Khởi tạo ApiService
    final apiService = ApiService();

    // Đăng ký các service và repository với Get.lazyPut
    Get.lazyPut(() => apiService);
    Get.lazyPut(() => UserRepository(Get.find<ApiService>()));
    Get.lazyPut(() => ProfileRepository(Get.find<ApiService>()));
    Get.lazyPut(() => EventRepository(Get.find<ApiService>()));
    Get.lazyPut(() => UnitRepository(Get.find<ApiService>()));
    Get.lazyPut(() => ClassRepository(Get.find<ApiService>()));
    Get.lazyPut(() => FacultyRepository(Get.find<ApiService>()));
    Get.lazyPut(() => CategoryRepository(Get.find<ApiService>()));

    Get.lazyPut(
        () => AuthController(userRepository: Get.find<UserRepository>()));
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignOutController());
    Get.lazyPut(() => SidebarController());
    Get.lazyPut(() => BottomNavController());
    Get.lazyPut(() => CalendarController());
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => EditProfileController());
    Get.lazyPut(() => EventController());
    Get.lazyPut(() => FaceScanController());
    // Get.lazyPut(() => FaceVerifyController());
    Get.lazyPut(() => QrScanController());
    Get.put(UserController(), permanent: true);
  }
}
