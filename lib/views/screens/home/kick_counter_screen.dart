import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/icons.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/widgets/icon_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/kick_counter_controller.dart';
import '../../layouts/custom_header.dart';

class KickCounterScreen extends StatelessWidget {
  final KickCounterController controller = Get.put(KickCounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EFFF),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(AppSpace.spaceMedium),
                child: CustomHeader(
                  headerTitle: 'Kick Counter',
                  isPreFixIcon: true,
                  isSuFixIcon: false,
                  prefixIconImage: AppIcons.ic_back,
                  prefixOnTap: () => Get.back(),
                ),
              ),
              if (controller.isCounting.value)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    "${controller.kicks.value} Kick${controller.kicks.value == 1 ? "" : "s"}",
                    style: AppTextStyle.textTitle1Style,
                  ),
                ),
              // Vòng tròn Start/Stop
              SizedBox(height: AppSpace.spaceMedium),
              GestureDetector(
                onTap: () {
                  if (controller.isCounting.value) {
                    controller.stopCounting();
                  } else {
                    controller.startCounting();
                  }
                },
                onLongPress: () {
                  if (controller.isCounting.value) controller.addKick();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.secondPrimaryColor,
                              blurRadius: 20,
                              spreadRadius: 4)
                        ],
                        border: Border.all(
                            color: AppColors.primaryColor, width: 8.px),
                      ),
                    ),
                    IconImageWidget(
                      iconImagePath: AppIcons.ic_foot,
                      width: 70.px,
                      height: 70.px,
                      iconColor: AppColors.whiteColor,
                    ),
                    Text(
                      controller.isCounting.value
                          ? "Stop".toUpperCase()
                          : "Start".toUpperCase(),
                      style: AppTextStyle.textH4Style.copyWith(
                        color: AppColors.whiteColor,
                        shadows: [
                          Shadow(color: AppColors.primaryColor, blurRadius: 6)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpace.spaceMedium),
              if (!controller.isCounting.value)
                Text(
                  "Press the button to start counting kicks",
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              if (controller.isCounting.value)
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpace.spaceSmall,
                      vertical: AppSpace.spaceMain),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            DateFormat.Hm().format(controller.startTime.value!),
                            style: AppTextStyle.textBody1Style
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Start of counting",
                            style: AppTextStyle.textBody3Style,
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: controller.addKick,
                        icon: Icon(Icons.add_rounded, color: Colors.white),
                        label: Text(
                          "Add Kick",
                          style: AppTextStyle.textBody1Style.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.px),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            controller.getTimeRemaining(),
                            style: AppTextStyle.textBody1Style
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Time remaining",
                            style: AppTextStyle.textBody3Style,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                    left: AppSpace.spaceMedium,
                    right: AppSpace.spaceMedium,
                    bottom: AppSpace.spaceMedium),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Journal",
                      style: AppTextStyle.textTitle1Style,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Padding(
                  padding: EdgeInsets.all(
                    AppSpace.spaceMedium,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Date and time",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                      ),
                      Expanded(
                        child: Text("Duration",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                      ),
                      Expanded(
                        child: Text("Kicks",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ),
              // Journal list
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Obx(() {
                    if (controller.journal.isEmpty) {
                      return Center(
                        child: Text(
                          "No data",
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: controller.journal.length,
                      itemBuilder: (context, i) {
                        final session = controller.journal[i];
                        final now = DateTime.now();
                        final dt = session.startTime;
                        final today = now.year == dt.year &&
                            now.month == dt.month &&
                            now.day == dt.day;
                        return ListTile(
                          dense: true,
                          onTap: () {}, // open detail
                          contentPadding: EdgeInsets.symmetric(horizontal: 18),
                          title: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  today
                                      ? "Today ${DateFormat.Hm().format(dt)}"
                                      : DateFormat("dd MMM HH:mm").format(dt),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  session.duration
                                      .toString()
                                      .split('.')
                                      .first
                                      .padLeft(8, "0"),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  session.kicks.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          trailing: Icon(Icons.chevron_right, size: 18),
                        );
                      },
                    );
                  }),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
