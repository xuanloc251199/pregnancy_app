import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/images.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/widgets/icon_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/mood_controller.dart';

class MoodTrackerScreen extends StatelessWidget {
  final MoodTrackerController controller = Get.put(MoodTrackerController());

  Color getMoodColor(String type, bool selected) {
    switch (type) {
      case 'positive':
        return selected
            ? AppColors.greenColor
            : AppColors.greenColor.withOpacity(0.28);
      case 'negative':
        return selected
            ? AppColors.redColor
            : AppColors.redColor.withOpacity(0.28);
      case 'neutral':
        return selected
            ? AppColors.yellowColor
            : AppColors.yellowColor.withOpacity(0.28);
      default:
        return AppColors.iconGreyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header with illustration
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpace.spaceMedium,
                vertical: AppSpace.paddingMain),
            decoration: BoxDecoration(
              color: AppColors.accentColor.withOpacity(0.25),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: AppSpace.spaceMedium,
                    top: AppSpace.spaceMedium,
                    bottom: AppSpace.spaceSmall,
                  ),
                  child: IconImageWidget(
                    iconImagePath: AppIcons.ic_back,
                    onTap: () => Get.back(),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: AppSpace.spaceMedium),
                    Text(
                      "Mood Tracker".toUpperCase(),
                      style: AppTextStyle.textH4Style,
                    ),
                    Spacer(),
                    Image.asset(
                      AppImage.moodTracker,
                      width: 130.px,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: AppSpace.spaceMedium),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpace.spaceMedium),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.paddingMain),
            child: Text(
              "How are you feeling right now?",
              style: AppTextStyle.textTitle1Style
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: AppSpace.spaceMedium),

          // PHẦN CHIP CẢM XÚC - DÙNG Obx RIÊNG!
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.paddingMain),
            child: Obx(() {
              return Wrap(
                spacing: AppSpace.spaceSmallW + 2,
                runSpacing: AppSpace.spaceSmall,
                children: controller.moods.map((mood) {
                  final selected = controller.selected.contains(mood);
                  final type = controller.moodColors[mood] ?? "neutral";
                  return GestureDetector(
                    onTap: () => controller.toggleMood(mood),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          color: getMoodColor(type, selected),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: getMoodColor(type, selected)
                                      .withOpacity(0.10),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                )
                              ]
                            : [],
                      ),
                      child: Text(
                        mood,
                        style: AppTextStyle.textBody2Style.copyWith(
                          color: getMoodColor(type, selected),
                          fontWeight:
                              selected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
          ),

          SizedBox(height: AppSpace.spaceLarge),

          // BUTTON LƯU - Chỉ cần Obx riêng
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.paddingMain),
            child: Obx(() {
              return ElevatedButton(
                onPressed: controller.selected.isNotEmpty
                    ? () => controller.saveMood()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.selected.isNotEmpty
                      ? AppColors.primaryColor
                      : AppColors.primaryColor.withOpacity(0.30),
                  shape: StadiumBorder(),
                  minimumSize: Size(double.infinity, 52),
                  elevation: 2,
                  shadowColor: AppColors.buttonShadowColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Save",
                      style: AppTextStyle.textButtonStyle.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: AppColors.whiteColor),
                  ],
                ),
              );
            }),
          ),
          SizedBox(height: AppSpace.spaceLarge - 6),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSpace.paddingMain, vertical: 2),
            child: Text(
              "Journal",
              style: AppTextStyle.textTitle2Style.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.paddingMain),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Date and time",
                    style: AppTextStyle.textSubTitle2Style.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Emotions",
                    style: AppTextStyle.textSubTitle2Style.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // LIST JOURNAL - Obx riêng
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.paddingMain),
            child: Obx(() {
              if (controller.journal.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpace.spaceLarge),
                  child: Center(
                    child: Text(
                      "No data",
                      style: AppTextStyle.textSubTitle1Style,
                    ),
                  ),
                );
              }
              return Column(
                children: controller.journal.map((entry) {
                  final dt = entry.time;
                  final now = DateTime.now();
                  final today = now.year == dt.year &&
                      now.month == dt.month &&
                      now.day == dt.day;
                  final emotion =
                      entry.emotions.isNotEmpty ? entry.emotions.first : "";
                  final type = controller.moodColors[emotion] ?? "neutral";
                  Color emotionColor;
                  switch (type) {
                    case 'positive':
                      emotionColor = AppColors.greenColor;
                      break;
                    case 'negative':
                      emotionColor = AppColors.redColor;
                      break;
                    case 'neutral':
                      emotionColor = AppColors.yellowColor;
                      break;
                    default:
                      emotionColor = AppColors.iconGreyColor;
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            today
                                ? "Today ${DateFormat.Hm().format(dt)}"
                                : DateFormat("dd MMM HH:mm").format(dt),
                            style: AppTextStyle.textBody2Style,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            emotion,
                            style: AppTextStyle.textBody2Style.copyWith(
                              color: emotionColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ),
          SizedBox(height: AppSpace.spaceLarge),
        ],
      ),
    );
  }
}
