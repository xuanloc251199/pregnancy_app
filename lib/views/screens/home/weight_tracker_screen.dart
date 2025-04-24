import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';

class WeightTrackerController extends GetxController {
  // Reactive variables for weight tracking
  final beforePregnancyWeight = 0.0.obs;
  final currentWeight = 0.0.obs;
  final reminderEnabled = true.obs;

  // Method to save weight
  void saveWeight() {
    // Implement weight saving logic
    print(
        'Saving Weight: Before Pregnancy: $beforePregnancyWeight, Current: $currentWeight');
  }

  // Method to toggle reminder
  void toggleReminder(bool? value) {
    reminderEnabled.value = value ?? false;
  }
}

class WeightTrackerScreen extends StatelessWidget {
  final WeightTrackerController controller = Get.put(WeightTrackerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpace.spaceMedium,
          vertical: AppSpace.paddingMain,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              isPreFixIcon: true,
              isSuFixIcon: false,
              prefixIconImage: AppIcons.ic_back,
              prefixOnTap: () => Get.back(),
              headerTitle: 'Weight Tracker',
              textStyle: AppTextStyle.textTitle1Style,
            ),
            SizedBox(height: AppSpace.paddingMain),
            _buildWeightBeforePregnancySection(),
            SizedBox(height: AppSpace.paddingMain),
            _buildCurrentWeightSection(),
            SizedBox(height: AppSpace.paddingMain),
            _buildReminderSection(),
            SizedBox(height: AppSpace.paddingMain),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightBeforePregnancySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight before pregnancy',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        _buildCustomTextField(
          hintText: 'Weight before pregnancy, kg',
          onChanged: (value) {
            controller.beforePregnancyWeight.value =
                double.tryParse(value) ?? 0.0;
          },
        ),
      ],
    );
  }

  Widget _buildCurrentWeightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current weight',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1.h),
        _buildCustomTextField(
          hintText: 'Weight right now, kg',
          onChanged: (value) {
            controller.currentWeight.value = double.tryParse(value) ?? 0.0;
          },
        ),
      ],
    );
  }

  Widget _buildReminderSection() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remind to check weight',
              style: TextStyle(fontSize: 12.sp),
            ),
            Switch.adaptive(
              value: controller.reminderEnabled.value,
              onChanged: controller.toggleReminder,
              activeColor: Colors.pink,
            ),
          ],
        ));
  }

  Widget _buildCustomTextField({
    required String hintText,
    required Function(String) onChanged,
  }) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.sp,
          vertical: 14.sp,
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildSaveButton() {
    return CustomButton(
      onPressed: controller.saveWeight,
      text: 'Save',
    );
  }
}
