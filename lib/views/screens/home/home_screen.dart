import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/strings.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/screens/home/tracking_tool.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/views/layouts/home/header.dart';

import '../../../controllers/pregnancy_info_controller.dart';
import '../../../controllers/side_bar_controller.dart';
import '../../../resources/images.dart';
import '../../layouts/home/custom_side_bar.dart';
import '../../widgets/process_info_widget.dart';

class HomeScreen extends StatelessWidget {
  final SidebarController _sidebarController = Get.find<SidebarController>();
  final pregnancyController = Get.find<PregnancyInfoController>();

  @override
  Widget build(BuildContext context) {
    pregnancyController.fetchPregnancyInfo();

    return Scaffold(
      body: Stack(
        children: [
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                left: _sidebarController.isSidebarOpen.value ? 0.0 : -75.w,
                top: 0.0,
                bottom: 0.0,
                child: CustomSideBar(),
              )),
          Obx(() => AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                left: _sidebarController.isSidebarOpen.value ? 70.w : 0.0,
                top: 0.0,
                right: _sidebarController.isSidebarOpen.value ? -70.w : 0.0,
                bottom: 0.0,
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_sidebarController.isSidebarOpen.value) {
                      _sidebarController.toggleSidebar();
                    }
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _buildHeader(),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            _buildFeatureCards(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondPrimaryColor, AppColors.primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpace.spaceMedium,
        vertical: AppSpace.paddingMain,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Header(sidebarController: _sidebarController),
            SizedBox(height: AppSpace.spaceMain),
            Obx(() => _buildProgressCircle(
                  pregnancyController.currentWeek.value,
                  pregnancyController.additionalDays.value,
                  pregnancyController.donePercent.value,
                )),
            SizedBox(height: AppSpace.spaceMain),
            Obx(() => _buildProgressInfo(
                  pregnancyController.donePercent.value,
                  pregnancyController.daysToGo.value,
                )),
            SizedBox(height: AppSpace.spaceMain),
            _buildMoreButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCircle(
      int currentWeek, int additionalDays, double donePercent) {
    return SizedBox(
      width: 140,
      height: 140,
      child: CustomPaint(
        painter: CircleProgressPainter(
          progressPercent: donePercent / 100,
          color: Colors.white,
          backgroundColor: Colors.white24,
        ),
        child: Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'WEEK\n',
                  style: AppTextStyle.textMainStyle,
                ),
                TextSpan(
                  text: '$currentWeek\n',
                  style: AppTextStyle.textH1Style,
                ),
                TextSpan(
                  text: '+$additionalDays days',
                  style: AppTextStyle.textMainStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressInfo(double donePercent, int daysToGo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProcessInfoWidget(
              value: '${donePercent.toStringAsFixed(1)}%', label: 'DONE'),
          ProcessInfoWidget(value: '$daysToGo', label: 'DAYS TO GO'),
        ],
      ),
    );
  }

  Widget _buildMoreButton() {
    return CustomButton(
      width: 50.w,
      onPressed: () {},
      text: 'More',
      backgroundColor: AppColors.whiteColor,
      textStyle:
          AppTextStyle.textButtonStyle.copyWith(color: AppColors.primaryColor),
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _FeatureCard(
                title: 'For Partner and loved ones',
                icon: Icons.favorite,
                iconColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              _FeatureImageCard(
                title: AppString.trackingTitle,
                buttonText: AppString.tracking,
                gradientColors: const [
                  AppColors.primaryColor,
                  AppColors.secondPrimaryColor,
                ],
                imageAsset: AppImage.motherTracking,
                onTap: () {
                  Get.to(TrackingToolsScreen());
                },
              ),
              SizedBox(height: AppSpace.spaceMedium),
              _FeatureImageCard(
                title: AppString.momCareTV,
                buttonText: AppString.watchNow,
                gradientColors: const [Color(0xFF70B9FF), Color(0xFF4D8DFC)],
                imageAsset: AppImage.momCare,
                onTap: () {},
              ),
              SizedBox(height: AppSpace.spaceMedium),
              _FeatureImageCard(
                title: AppString.todoList,
                buttonText: AppString.checkNow,
                gradientColors: const [Color(0xFF9477FF), Color(0xFF7C55F7)],
                imageAsset: AppImage.todoList,
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double progressPercent;
  final Color color;
  final Color backgroundColor;

  CircleProgressPainter({
    required this.progressPercent,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = (size.width / 2) - 10;
    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, bgPaint);
    double sweepAngle = 2 * 3.141592653589793 * progressPercent;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircleProgressPainter oldDelegate) =>
      oldDelegate.progressPercent != progressPercent;
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(icon, size: 28, color: iconColor),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureImageCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final List<Color> gradientColors;
  final String imageAsset;
  final VoidCallback onTap;

  const _FeatureImageCard({
    required this.title,
    required this.buttonText,
    required this.gradientColors,
    required this.imageAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 16.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyle.textTitle1DarkStyle,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(width: AppSpace.spaceMedium),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.white24,
                    width: 90,
                    height: 90,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported,
                        size: 32, color: Colors.white30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
