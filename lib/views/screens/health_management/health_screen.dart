import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/calendar_controller.dart';
import '../../../controllers/event_controller.dart';
import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../resources/strings.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';
import '../../widgets/icon_image_widget.dart';

class EventScreen extends StatelessWidget {
  final EventController eventController = Get.put(EventController());
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
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
            final isToday = calendarController.isToday(date);
            return Container(
              margin: EdgeInsets.all(AppSpace.spaceSmallW),
              decoration: BoxDecoration(
                color:
                    isToday ? AppColors.primaryShadowColor : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: isToday
                    ? Border.all(color: AppColors.primaryColor, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyle.textBody1Style,
                ),
              ),
            );
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

              // Lưới hiển thị lịch
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(bottom: AppSpace.spaceMain),
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
                  child: GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 7,
                    children: dayWidgets,
                  ),
                ),
              ),

              // (Có thể mở lại phần Event Section nếu cần)
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
