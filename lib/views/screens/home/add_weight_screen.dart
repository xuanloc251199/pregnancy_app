import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/resources/strings.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';

// Weight Tracker Controller
class WeightTrackerController extends GetxController {
  final RxDouble initialWeight = 0.0.obs;
  final RxDouble currentWeight = 0.0.obs;
  final RxBool isReminderEnabled = false.obs;

  void updateInitialWeight(String value) {
    initialWeight.value = double.tryParse(value) ?? 0.0;
  }

  void updateCurrentWeight(String value) {
    currentWeight.value = double.tryParse(value) ?? 0.0;
  }

  void toggleReminder(bool? value) {
    isReminderEnabled.value = value ?? false;
  }

  void saveWeightData() {
    // Implement save logic
    Get.snackbar(
      'Weight Tracker',
      'Weight data saved successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class AddWeightScreen extends StatelessWidget {
  final WeightTrackerController controller = Get.put(WeightTrackerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Weight Tracker',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWeightBeforePregnancySection(),
          SizedBox(height: 2.h),
          _buildCurrentWeightSection(),
          SizedBox(height: 2.h),
          _buildReminderSection(),
          Spacer(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildWeightBeforePregnancySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weight before pregnancy',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        _buildCustomTextField(
          hintText: 'Weight before pregnancy, kg',
          onChanged: controller.updateInitialWeight,
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
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        _buildCustomTextField(
          hintText: 'Weight right now, kg',
          onChanged: controller.updateCurrentWeight,
        ),
      ],
    );
  }

  Widget _buildReminderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Remind to check weight',
          style: TextStyle(fontSize: 12.sp),
        ),
        Obx(
          () => Switch(
            value: controller.isReminderEnabled.value,
            onChanged: controller.toggleReminder,
            activeColor: Colors.pink,
          ),
        ),
      ],
    );
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
      text: AppString.save,
      onPressed: controller.saveWeightData,
    );
  }
}
