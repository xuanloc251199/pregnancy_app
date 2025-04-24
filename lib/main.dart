import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/bindings/app_binding.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/resources/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await initializeDateFormatting('vi', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pregnancy App',
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundWhiteColor,
            appBarTheme: AppBarTheme(
              color: AppColors.backgroundWhiteColor,
            ),
          ),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.pages,
          initialBinding: AppBinding(), // binding tổng
        );
      },
    );
  }
}
