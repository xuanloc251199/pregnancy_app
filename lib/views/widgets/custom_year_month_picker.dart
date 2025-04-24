import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/sizes.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../resources/icons.dart';
import '../../styles/_text_header_style.dart';
import 'icon_image_widget.dart';

class CustomYearMonthPicker extends StatefulWidget {
  final int initialYear;
  final int initialMonth;

  const CustomYearMonthPicker({
    Key? key,
    required this.initialYear,
    required this.initialMonth,
  }) : super(key: key);

  @override
  State<CustomYearMonthPicker> createState() => _CustomYearMonthPickerState();
}

class _CustomYearMonthPickerState extends State<CustomYearMonthPicker> {
  late int currentYear;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    currentYear = widget.initialYear;
    selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final months = List.generate(12, (i) => i + 1);
    return Dialog(
      child: Container(
        width: 80.w,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppSizes.brMain)),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header chọn năm với mũi tên
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconImageWidget(
                  iconImagePath: AppIcons.ic_left,
                  onTap: () {
                    setState(() {
                      currentYear--;
                    });
                  },
                ),
                Text(
                  '$currentYear',
                  style: AppTextStyle.textTitle2Style,
                ),
                IconImageWidget(
                  iconImagePath: AppIcons.ic_right,
                  onTap: () {
                    setState(() {
                      currentYear++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: AppSpace.spaceMain),
            // Lưới tháng
            GridView.builder(
              shrinkWrap: true,
              itemCount: 12,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 cột như hình
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (_, idx) {
                final monthNum = months[idx];
                final isSelected = monthNum == selectedMonth;
                return GestureDetector(
                  onTap: () {
                    selectedMonth = monthNum;
                    Get.back(
                        result: {'year': currentYear, 'month': selectedMonth});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.hidenBackgroundColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: isSelected
                          ? Border.all(color: AppColors.primaryColor, width: 2)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat.MMM('vi').format(DateTime(2000, monthNum)),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: AppSpace.spaceMain,
            ),
            CustomButton(
              onPressed: () => Get.back(),
              text: 'Canel',
            ),
          ],
        ),
      ),
    );
  }
}
