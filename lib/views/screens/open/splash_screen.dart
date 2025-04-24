import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() async {
    await Future.delayed(const Duration(seconds: 2));
    authController.handleAutoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhiteColor,
      body: Center(
        child: Image.asset(AppIcons.logo_app),
      ),
    );
  }
}
