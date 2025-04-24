import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/bottom_nav_controller.dart';
import 'package:pregnancy_app/views/screens/health_management/health_screen.dart';
import 'package:pregnancy_app/views/screens/home/home_screen.dart';
import 'package:pregnancy_app/views/screens/note/note_screen.dart';
import 'package:pregnancy_app/views/screens/profile/profile_screen.dart';

import '../layouts/custom_bottom_nav_bar.dart';
import 'baby/baby_generator_screen.dart';

class BaseScreen extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  final List<Widget> screens = [
    HomeScreen(),
    HealthScreen(),
    BabyGeneratorScreen(),
    NoteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return screens[bottomNavController.selectedIndex.value];
      }),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
