import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarController extends GetxController {
  var currentDate = DateTime.now().obs;
  var selectedDate = DateTime.now().obs;

  /// Chuyển tháng theo bước `step` (+1: tháng sau, -1: tháng trước)
  void changeMonth(int step) {
    final newDate = DateTime(
      currentDate.value.year,
      currentDate.value.month + step,
    );
    currentDate.value = newDate;
  }

  /// Chuyển sang năm cụ thể
  void changeYear(int year) {
    final newDate = DateTime(
      year,
      currentDate.value.month,
    );
    currentDate.value = newDate;
  }

  /// Lấy danh sách các ngày trong tháng hiện tại
  List<DateTime> getMonthDays() {
    int year = currentDate.value.year;
    int month = currentDate.value.month;
    int totalDays = DateUtils.getDaysInMonth(year, month);

    return List.generate(totalDays, (index) {
      return DateTime(year, month, index + 1);
    });
  }

  /// Lấy ngày đầu tiên của tháng (dùng để căn chỉnh ngày trong tuần)
  int getStartWeekday() {
    return DateTime(currentDate.value.year, currentDate.value.month, 1).weekday;
  }

  /// Kiểm tra xem ngày được truyền vào có phải là hôm nay không
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  /// Khi bấm vào 1 ngày trên calendar
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  String formatPregnancyDate(DateTime date) {
    final months = [
      '', // 0
      'Tháng Một',
      'Tháng Hai',
      'Tháng Ba',
      'Tháng Tư',
      'Tháng Năm',
      'Tháng Sáu',
      'Tháng Bảy',
      'Tháng Tám',
      'Tháng Chín',
      'Tháng Mười',
      'Tháng Mười Một',
      'Tháng Mười Hai',
    ];
    return '${date.day.toString().padLeft(2, '0')} - ${months[date.month]} - ${date.year}';
  }

  DateTime? getExpectedDateOfBirth(DateTime? pregnancyDate) {
    if (pregnancyDate == null) return null;
    return pregnancyDate.add(const Duration(days: 280));
  }
}
