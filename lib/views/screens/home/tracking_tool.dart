import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/views/screens/home/mood_selection_screen.dart';
import 'package:pregnancy_app/views/screens/home/mood_tracker_screen.dart';
import 'package:pregnancy_app/views/screens/home/weight_tracker_screen.dart';
import 'package:pregnancy_app/views/widgets/tracking_card_widget.dart';
import '../../../resources/spaces.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';

class TrackingToolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpace.spaceMedium,
                vertical: AppSpace.paddingMain,
              ),
              child: CustomHeader(
                isPreFixIcon: true,
                isSuFixIcon: false,
                prefixIconImage: AppIcons.ic_back,
                prefixOnTap: () => Get.back(),
                headerTitle: 'Tracking tool',
                textStyle: AppTextStyle.textTitle1Style,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: [
                  TrackingCardWidget(
                    title: 'Health Report\nin PDF',
                    imagePath: 'assets/images/health_report.png',
                    backgroundColor: AppColors.primaryColor,
                    onTap: () {
                      // TODO: handle PDF report
                    },
                  ),
                  TrackingCardWidget(
                    title: 'Weight Tracker',
                    imagePath: 'assets/images/weight_tracker.png',
                    backgroundColor: Color(0xFFF46A6A),
                    onTap: () {
                      Get.to(() => WeightTrackerScreen());
                    },
                  ),
                  TrackingCardWidget(
                    title: 'Kick counter',
                    imagePath: 'assets/images/kick_counter.png',
                    backgroundColor: Color(0xFF96D267),
                    onTap: () {
                      Get.toNamed(AppRoutes.kickCounter);
                    },
                  ),
                  TrackingCardWidget(
                    title: 'Mood Tracker',
                    imagePath: 'assets/icons/ic_mood.png',
                    backgroundColor: Color(0xFF3F469A),
                    onTap: () {
                      Get.to(() => MoodTrackerScreen());
                    },
                  ),
                  TrackingCardWidget(
                    title: 'Tummy Growth',
                    imagePath: 'assets/images/tummy_growth.png',
                    backgroundColor: Color(0xFFFFC1FD),
                    onTap: () {
                      // TODO: handle tummy growth
                    },
                  ),
                  TrackingCardWidget(
                    title: 'Pressure Monitor',
                    imagePath: 'assets/images/pressure_monitor.png',
                    backgroundColor: Color(0xFFA1A1A1),
                    onTap: () {
                      // TODO: handle pressure monitor
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
