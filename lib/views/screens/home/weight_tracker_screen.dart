import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/weight_controller.dart';
import 'package:pregnancy_app/views/widgets/icon_image_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../resources/sizes.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field_widget.dart';

class WeightTrackerScreen extends StatelessWidget {
  final TextEditingController _weightController = TextEditingController();
  final WeightController controller = Get.put(WeightController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildJournalHeader(),
            _buildJournalList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondPrimaryColor, AppColors.primaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpace.spaceMedium,
                vertical: AppSpace.paddingMain,
              ),
              child: CustomHeader(
                isPreFixIcon: true,
                isSuFixIcon: false,
                prefixIconImage: AppIcons.ic_back,
                prefixOnTap: () => Get.back(),
                prefixIconColor: AppColors.whiteColor,
                headerTitle: 'Tracking tool',
                textStyle: AppTextStyle.textTitle1Style.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
            child: Text(
              'Weight Tracker',
              style: AppTextStyle.textTitle1DarkStyle.copyWith(
                fontSize: AppSizes.tsH4,
              ),
            ),
          ),
          SizedBox(height: AppSpace.spaceMain),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpace.spaceMedium,
              vertical: AppSpace.spaceMedium,
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _weightController,
                    hintText: 'Enter new weight, kg',
                    keyboardType: TextInputType.number,
                    borderRadius: 25.w,
                    backgroundColor: AppColors.whiteColor,
                    isFill: true,
                  ),
                ),
                SizedBox(width: AppSpace.spaceMedium),
                CustomButton(
                  onPressed: () {
                    final input = _weightController.text;
                    if (input.isNotEmpty) {
                      controller.addWeight(double.parse(input));
                      _weightController.clear();
                    } else {
                      Get.snackbar('Lỗi', 'Vui lòng nhập cân nặng');
                    }
                  },
                  text: 'Add',
                  width: 25.w,
                  radius: 20.w,
                  backgroundColor: AppColors.whiteColor,
                  textStyle: AppTextStyle.textMainStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJournalHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSpace.spaceMedium),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
          child: Text(
            'Journal',
            style:
                AppTextStyle.textH2Style.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: AppSpace.spaceSmall),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                  child: Text('Date',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text('Weight',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text('Gain',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              Expanded(
                  child: Text('Week',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJournalList() {
    return Expanded(
      child: Obx(() {
        final weights = controller.weights;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (weights.isEmpty) {
          return Center(child: Text('Chưa có dữ liệu cân nặng.'));
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
          child: ListView.separated(
            itemCount: weights.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = weights[index];
              final gain = index < weights.length - 1
                  ? (entry.weight - weights[index + 1].weight)
                      .toStringAsFixed(1)
                  : '+0.0';

              final week = DateTime.now()
                      .difference(DateTime.parse(entry.date))
                      .inDays ~/
                  7;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpace.spaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(DateFormat('dd/MM/yyyy')
                            .format(DateTime.parse(entry.date)))),
                    Expanded(child: Text('${entry.weight} kg')),
                    Expanded(
                        child: Text('+ $gain kg',
                            style: TextStyle(color: Colors.blue))),
                    Expanded(child: Text('$week')),
                    IconImageWidget(iconImagePath: AppIcons.ic_right),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
