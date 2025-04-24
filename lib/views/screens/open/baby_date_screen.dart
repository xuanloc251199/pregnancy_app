import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/sizes.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:pregnancy_app/views/widgets/custom_text_field_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/calendar_controller.dart';
import '../../../controllers/pregnancy_info_controller.dart';
import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../styles/_text_header_style.dart';
import '../../widgets/icon_image_widget.dart';

class BabyDateScreen extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());
  final PregnancyInfoController pregnancyInfoController =
      Get.put(PregnancyInfoController());
  final TextEditingController dateController = TextEditingController();

  BabyDateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Khi màn hình vào, fetch ngày đã lưu 1 lần (chỉ cần gọi 1 lần khi vào màn hình)
    pregnancyInfoController.fetchPregnancyInfo();

    ever(calendarController.selectedDate, (date) {
      dateController.text = calendarController.formatPregnancyDate(date);
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.whiteColor, AppColors.primaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Obx(() {
              final currentDate = calendarController.currentDate.value;
              final daysInMonth = calendarController.getMonthDays();
              final startWeekday = calendarController.getStartWeekday();

              List<Widget> dayWidgets = List.generate(
                startWeekday == 7 ? 0 : startWeekday % 7,
                (_) => const SizedBox.shrink(),
              );

              dayWidgets.addAll(daysInMonth.map((date) {
                return Obx(() {
                  final isToday = calendarController.isToday(date);
                  final isSelected =
                      calendarController.selectedDate.value.year == date.year &&
                          calendarController.selectedDate.value.month ==
                              date.month &&
                          calendarController.selectedDate.value.day == date.day;

                  // Ngày đã lưu là ngày mang thai
                  final isPregnancyDate = pregnancyInfoController
                              .savedPregnantDate.value !=
                          null &&
                      pregnancyInfoController.savedPregnantDate.value!.year ==
                          date.year &&
                      pregnancyInfoController.savedPregnantDate.value!.month ==
                          date.month &&
                      pregnancyInfoController.savedPregnantDate.value!.day ==
                          date.day;

                  return GestureDetector(
                    onTap: () {
                      calendarController.selectDate(date);
                    },
                    child: Container(
                      margin: EdgeInsets.all(AppSpace.spaceSmallW),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor.withOpacity(0.7)
                            : isToday
                                ? AppColors.primaryShadowColor
                                : isPregnancyDate
                                    ? Colors.pinkAccent.withOpacity(0.18)
                                    : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.primaryColor, width: 2)
                            : isPregnancyDate
                                ? Border.all(color: Colors.pink, width: 2)
                                : isToday
                                    ? Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.5)
                                    : null,
                      ),
                      child: Center(
                        child: isPregnancyDate
                            ? Image.asset(AppIcons.ic_baby_3d)
                            : Text(
                                '${date.day}',
                                style: AppTextStyle.textBody1Style.copyWith(
                                  color: isSelected ? Colors.white : null,
                                  fontWeight:
                                      isSelected ? FontWeight.bold : null,
                                ),
                              ),
                      ),
                    ),
                  );
                });
              }));

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppSpace.spaceMedium,
                      right: AppSpace.spaceMedium,
                      top: AppSpace.spaceLarge,
                    ),
                    child: Container(
                      width: 100.w,
                      padding: EdgeInsets.all(AppSpace.spaceMedium),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.px),
                        color: AppColors.hidenBackgroundColor,
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Enter the first day of your last period to calculate your due date',
                            style: AppTextStyle.textH5Style.copyWith(
                                fontWeight: FontWeight.w900, fontSize: 20.px),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: AppSpace.spaceSmall,
                          ),
                          Text(
                            'Why are we asking and how we calculate it?',
                            style: AppTextStyle.textBody3Style
                                .copyWith(decoration: TextDecoration.underline),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppSpace.spaceMain,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpace.spaceMedium,
                    ),
                    child: Column(
                      children: [
                        CustomTextFieldWidget(
                          controller: dateController,
                          hintText: 'Enter date ( Example:  2025-05-15)',
                          isFill: true,
                          backgroundColor: AppColors.whiteColor,
                        ),
                        SizedBox(
                          height: AppSpace.spaceMain,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(22.px),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                blurRadius: 19.px,
                                offset: Offset(0, 16),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(AppSpace.spaceMedium),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconImageWidget(
                                    iconImagePath: AppIcons.ic_left,
                                    onTap: () {
                                      calendarController.changeMonth(-1);
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // showYearPicker(context, currentDate.year);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: AppSpace.spaceMain),
                                      child: Text(
                                        DateFormat.yMMMM('vi')
                                            .format(currentDate)
                                            .toUpperCase(),
                                        style: AppTextStyle.textTitle2Style,
                                      ),
                                    ),
                                  ),
                                  IconImageWidget(
                                    iconImagePath: AppIcons.ic_right,
                                    onTap: () {
                                      calendarController.changeMonth(1);
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: AppSpace.spaceMedium,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  'T2',
                                  'T3',
                                  'T4',
                                  'T5',
                                  'T6',
                                  'T7',
                                  'CN'
                                ].map((day) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(day,
                                          style: AppTextStyle.textBody1Style),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: AppSpace.spaceMedium,
                              ),
                              GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 7,
                                children: dayWidgets,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSpace.spaceMain,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
                    child: CustomButton(
                      text: 'CONTINUE',
                      radius: 50.px,
                      backgroundColor: AppColors.whiteColor,
                      textStyle: AppTextStyle.textButtonStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                      onPressed: () {
                        final selectedDate =
                            calendarController.selectedDate.value;
                        final dateString =
                            "${selectedDate.year.toString().padLeft(4, '0')}"
                            "-${selectedDate.month.toString().padLeft(2, '0')}"
                            "-${selectedDate.day.toString().padLeft(2, '0')}";
                        pregnancyInfoController.savePregnancyDate(dateString);
                      },
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
