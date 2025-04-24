import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/sizes.dart';
import 'package:pregnancy_app/routes/app_route.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/calendar_controller.dart';
import '../../../controllers/pregnancy_info_controller.dart';
import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../resources/strings.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';
import '../../widgets/custom_year_month_picker.dart';
import '../../widgets/icon_image_widget.dart';

class HealthScreen extends StatelessWidget {
  final CalendarController calendarController = Get.put(CalendarController());
  final PregnancyInfoController pregnancyInfoController =
      Get.put(PregnancyInfoController());
  final TextEditingController dateController = TextEditingController();

  HealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pregnancyInfoController.fetchPregnancyInfo();

    ever(calendarController.selectedDate, (date) {
      dateController.text = calendarController.formatPregnancyDate(date);
    });
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final currentDate = calendarController.currentDate.value;
          final daysInMonth = calendarController.getMonthDays();
          final startWeekday = calendarController.getStartWeekday();

          // Tạo lưới các ngày, có căn chỉnh bằng ô trống đầu tuần
          List<Widget> dayWidgets = List.generate(
            startWeekday == 7 ? 0 : startWeekday % 7,
            (_) => const SizedBox.shrink(),
          );

          dayWidgets.addAll(daysInMonth.map((date) {
            return Obx(() {
              final isToday = calendarController.isToday(date);
              final isSelected = calendarController.selectedDate.value.year ==
                      date.year &&
                  calendarController.selectedDate.value.month == date.month &&
                  calendarController.selectedDate.value.day == date.day;

              // Ngày mang thai
              final isPregnancyDate =
                  pregnancyInfoController.savedPregnantDate.value != null &&
                      pregnancyInfoController.savedPregnantDate.value!.year ==
                          date.year &&
                      pregnancyInfoController.savedPregnantDate.value!.month ==
                          date.month &&
                      pregnancyInfoController.savedPregnantDate.value!.day ==
                          date.day;

              // Ngày dự sinh
              final expectedDate = calendarController.getExpectedDateOfBirth(
                  pregnancyInfoController.savedPregnantDate.value);
              final isExpectedDate = expectedDate != null &&
                  expectedDate.year == date.year &&
                  expectedDate.month == date.month &&
                  expectedDate.day == date.day;

              // Nếu là ngày mang thai hoặc ngày dự sinh thì chỉ hiện icon
              final showBabyIcon = isPregnancyDate || isExpectedDate;

              String? iconPath;
              if (isPregnancyDate) {
                iconPath = AppIcons.ic_baby_3d;
              } else if (isExpectedDate) {
                iconPath = AppIcons.ic_born;
              }

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
                                ? AppColors.primaryColor.withOpacity(0.18)
                                : isExpectedDate
                                    ? AppColors.accentColor
                                        .withAlpha(AppColors.colorAlphaSub)
                                    : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(color: AppColors.primaryColor, width: 2)
                        : isPregnancyDate
                            ? Border.all(color: Colors.pink, width: 2)
                            : isExpectedDate
                                ? Border.all(color: Colors.blue, width: 2)
                                : isToday
                                    ? Border.all(
                                        color: AppColors.primaryColor,
                                        width: 1.5)
                                    : null,
                  ),
                  child: Center(
                    child: showBabyIcon && iconPath != null
                        ? Image.asset(iconPath, width: 28, height: 28)
                        : Text(
                            '${date.day}',
                            style: AppTextStyle.textBody1Style.copyWith(
                              color: isSelected ? Colors.white : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                  ),
                ),
              );
            });
          }));

          return CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpace.spaceMedium,
                    vertical: AppSpace.paddingMain,
                  ),
                  child: CustomHeader(
                    isPreFixIcon: false,
                    isSuFixIcon: false,
                    headerTitle: AppString.labelEvent,
                    textStyle: AppTextStyle.textTitle1Style,
                  ),
                ),
              ),

              // Thanh điều hướng tháng
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconImageWidget(
                        iconImagePath: AppIcons.ic_left,
                        onTap: () {
                          calendarController.changeMonth(-1);
                        },
                      ),
                      GestureDetector(
                        onTap: () async {
                          final selected = await Get.dialog<Map<String, int>>(
                            CustomYearMonthPicker(
                              initialYear: currentDate.year,
                              initialMonth: currentDate.month,
                            ),
                            barrierDismissible: true,
                          );
                          if (selected != null) {
                            calendarController.currentDate.value =
                                DateTime(selected['year']!, selected['month']!);
                          }
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
                ),
              ),

              // Hiển thị thứ trong tuần
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpace.spaceMedium),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'].map((day) {
                      return Expanded(
                        child: Center(
                          child: Text(day, style: AppTextStyle.textBody1Style),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: AppSpace.spaceMain),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSpace.spaceMedium),
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 7,
                        children: dayWidgets,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSpace.spaceMedium),
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              text: 'Đăng ký lịch khám',
                              textStyle: AppTextStyle.textBody3Style
                                  .copyWith(color: AppColors.whiteColor),
                              onPressed: () {
                                Get.toNamed(AppRoutes.booking);
                              },
                            ),
                          ),
                          SizedBox(width: 12), // Khoảng cách giữa hai nút
                          Expanded(
                            child: CustomButton(
                              text: 'Xem lịch khám',
                              textStyle: AppTextStyle.textBody3Style
                                  .copyWith(color: AppColors.whiteColor),
                              backgroundColor: AppColors.accentColor,
                              borderColor: AppColors.accentColor,
                              onPressed: () {
                                Get.toNamed(AppRoutes.appointments);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSpace.spaceMedium,
                      vertical: AppSpace.spaceMain),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'your due date'.toUpperCase(),
                        style: AppTextStyle.textTitle1Style,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: AppSpace.spaceSmall,
                      ),
                      Obx(() {
                        final date =
                            pregnancyInfoController.savedPregnantDate.value;
                        if (date == null) {
                          return Text(
                            'Pregnancy Date',
                            style: AppTextStyle.textTitle1Style,
                          );
                        }
                        return Text(
                          calendarController.formatPregnancyDate(date),
                          style: AppTextStyle.textBody1Style,
                        );
                      }),
                      SizedBox(
                        height: AppSpace.spaceMain,
                      ),
                      Text(
                        'expected date of birth'.toUpperCase(),
                        style: AppTextStyle.textTitle1Style,
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(
                        height: AppSpace.spaceSmall,
                      ),
                      Obx(() {
                        final pregnantDate =
                            pregnancyInfoController.savedPregnantDate.value;
                        final expectedDate = calendarController
                            .getExpectedDateOfBirth(pregnantDate);
                        if (expectedDate == null) {
                          return Text(
                            'Chưa có ngày dự sinh',
                            style: AppTextStyle.textTitle1Style,
                          );
                        }
                        return Text(
                          calendarController.formatPregnancyDate(expectedDate),
                          style: AppTextStyle.textBody1Style,
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  void showYearPicker(BuildContext context, int currentYear) {
    showDialog(
      context: context,
      builder: (context) {
        return YearPicker(
          selectedDate: DateTime(currentYear),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          onChanged: (date) {
            calendarController.changeYear(date.year);
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
