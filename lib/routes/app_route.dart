import 'package:get/get.dart';
import 'package:pregnancy_app/views/screens/auth/sign_up_screen.dart';
import 'package:pregnancy_app/views/screens/open/baby_date_screen.dart';
import '../bindings/auth_binding.dart';
import '../views/screens/auth/sign_in_screen.dart';
import '../views/screens/health_management/booking_appointment_screen.dart';
import '../views/screens/open/splash_screen.dart';
import '../views/screens/base_screen.dart';

// Nếu có màn verification_screen v.v, import thêm ở đây

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const babydate = '/babydate';
  static const base = '/base';
  // static const verify = '/verify';
  static const booking = '/booking';

  static final pages = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
      binding: AuthBinding(), // Nếu màn này cần controller
    ),
    GetPage(
      name: login,
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: signup,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: base,
      page: () => BaseScreen(),
      // binding: BaseBinding(), // Nếu có
    ),
    // GetPage(
    //   name: verify,
    //   page: () => VerificationScreen(),
    //   binding: AuthBinding(),
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
  ];
}
