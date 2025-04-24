import 'package:get/get.dart';
import 'package:pregnancy_app/bindings/app_binding.dart';
import 'package:pregnancy_app/views/screens/auth/add_information_screen.dart';
import 'package:pregnancy_app/views/screens/auth/instruct_screen.dart';
import 'package:pregnancy_app/views/screens/base_screen.dart';
import 'package:pregnancy_app/views/screens/health_management/health_detail_screen.dart';
import 'package:pregnancy_app/views/screens/face_verify_screen.dart';
import 'package:pregnancy_app/views/screens/profile/edit_profile_screen.dart';
import 'package:pregnancy_app/views/screens/face_scan_screen.dart';
import 'package:pregnancy_app/views/screens/profile/profile_screen.dart';
import 'package:pregnancy_app/views/screens/profile/qr_scan_screen.dart';
import 'package:pregnancy_app/views/screens/auth/sign_in_screen.dart';
import 'package:pregnancy_app/views/screens/auth/sign_up_screen.dart';
import 'package:pregnancy_app/views/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String instruct = '/instruct';
  static const String addInfor = '/addInfor';
  static const String base = '/base';
  static const String navBar = '/customNavBar';

  static const String profile = '/profile';
  static const String editProfile = '/editProfile';
  static const String qrScan = '/qrScan';
  static const String faceScan = '/faceScan';
  static const String faceVerify = '/faceVerify';
  static const String faceVerifyId = '/faceVerifyId';

  static const String eventDetail = '/event-detail';

  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: signUp,
      page: () => SignUpScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: instruct,
      page: () => InstructScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: addInfor,
      page: () => AddInformationScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: base,
      page: () => BaseScreen(),
    ),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: editProfile,
      page: () => EditProfileScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: qrScan,
      page: () => QrScanScreen(),
    ),
    GetPage(
      name: faceScan,
      page: () => FaceScanScreen(),
    ),
    // GetPage(
    //   name: faceVerify,
    //   page: () => FaceVerifyScreen(),
    //   binding: AppBinding(),
    // ),
    // GetPage(
    //   name: eventDetail,
    //   page: () => EventDetailScreen(
    //     eventId: Get.parameters['eventId'] ?? '',
    //   ),
    // ),
  ];
}
