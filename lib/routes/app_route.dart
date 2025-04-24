import 'package:get/get.dart';
import 'package:pregnancy_app/bindings/app_binding.dart';
import 'package:pregnancy_app/views/screens/auth/sign_up_screen.dart';
import 'package:pregnancy_app/views/screens/home/kick_counter_screen.dart';
import 'package:pregnancy_app/views/screens/open/baby_date_screen.dart';
import 'package:pregnancy_app/views/screens/profile/change_password_screen.dart';
import '../bindings/auth_binding.dart';
import '../views/screens/auth/sign_in_screen.dart';
import '../views/screens/health_management/appointment_list_screen.dart';
import '../views/screens/health_management/booking_appointment_screen.dart';
import '../views/screens/note/note_screen.dart';
import '../views/screens/open/splash_screen.dart';
import '../views/screens/base_screen.dart';
import '../views/screens/profile/update_profile_screen.dart';

// Nếu có màn verification_screen v.v, import thêm ở đây

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const babydate = '/babydate';
  static const base = '/base';
  // static const verify = '/verify';
  static const booking = '/booking';
  static const note = '/note';
  static const updateProfile = '/update_profile';
  static const changePassword = '/change_password';
  static const kickCounter = '/kick_counter';
  static const appointments = '/appointments';

  static final pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      binding: AppBinding(), // Nếu màn này cần controller
    ),
    GetPage(
      name: login,
      page: () => SignInScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpScreen(),
      binding: AppBinding(),
    ),
    GetPage(
      name: base,
      page: () => BaseScreen(),
      binding: AppBinding(), // Nếu có
    ),
    // GetPage(
    //   name: verify,
    //   page: () => VerificationScreen(),
    //   binding: AppBinding(),
    // ),
    GetPage(
      name: babydate,
      page: () => BabyDateScreen(),
      // binding: BaseBinding(), // Nếu có
    ),
    GetPage(
      name: booking,
      page: () => BookingAppointmentScreen(),
      // binding: BookingBinding(), // Nếu có cần controller riêng
    ),
    GetPage(
      name: note,
      page: () => NoteScreen(),
    ),
    GetPage(
      name: updateProfile,
      page: () => UpdateProfileScreen(),
      // Không cần binding riêng nếu ProfileController đã được AppBinding permanent
    ),
    GetPage(
      name: changePassword,
      page: () => ChangePasswordScreen(),
      // Không cần binding riêng nếu ProfileController đã được AppBinding permanent
    ),
    GetPage(
      name: kickCounter,
      page: () => KickCounterScreen(),
      // Không cần binding riêng nếu ProfileController đã được AppBinding permanent
    ),
    GetPage(
      name: AppRoutes.appointments,
      page: () => AppointmentListScreen(),
    )
  ];
}
