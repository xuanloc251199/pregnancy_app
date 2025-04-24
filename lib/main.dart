import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/bindings/app_binding.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/services/api_service.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Làm cho thanh trạng thái trong suốt
      statusBarIconBrightness: Brightness.dark, // Biểu tượng màu tối
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo ApiService
  final apiService = ApiService();

  // Đăng ký các service và repository với Get.lazyPut
  // Get.lazyPut(() => apiService);
  // Get.lazyPut(() => UserRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => ProfileRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => EventRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => UnitRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => ClassRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => FacultyRepository(Get.find<ApiService>()));
  // Get.lazyPut(() => CategoryRepository(Get.find<ApiService>()));

  // Get.lazyPut(() => SidebarController());
  // Get.lazyPut(() => BottomNavController());
  // Get.lazyPut(() => CalendarController());
  // Get.lazyPut(() => CategoryController());
  // Get.lazyPut(() => EditProfileController());
  // Get.lazyPut(() => EventController());
  // Get.lazyPut(() => FaceScanController());
  // Get.lazyPut(() => FaceVerifyController());
  // Get.lazyPut(() => QrScanController());
  // Get.lazyPut(() => SignInController());
  // Get.lazyPut(() => SignOutController());

  // Đăng ký định dạng ngày
  await initializeDateFormatting('vi', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Event',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundWhiteColor,
            appBarTheme: AppBarTheme(
              color: AppColors.backgroundWhiteColor,
            ),
          ),
          initialBinding: AppBinding(),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
