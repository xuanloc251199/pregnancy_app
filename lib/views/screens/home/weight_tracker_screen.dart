import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/views/widgets/icon_image_widget.dart';
import 'package:sizer/sizer.dart';

import '../../../resources/colors.dart';
import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../resources/sizes.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field_widget.dart';

class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({super.key});

  @override
  State<WeightTrackerScreen> createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final TextEditingController _weightController = TextEditingController();
  final List<Map<String, String>> _journalEntries = [];

  void _addWeight() {
    if (_weightController.text.isNotEmpty) {
      setState(() {
        _journalEntries.insert(0, {
          'date': 'Today',
          'weight': '${_weightController.text} kg',
          'gain': '+ 3 kg', // Logic tăng cân nên thay đổi theo thực tế
          'week': '8',
        });
        _weightController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondPrimaryColor,
                    AppColors.primaryColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpace.spaceMedium,
                    ),
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
                            onChanged: (value) {},
                            backgroundColor: AppColors.whiteColor,
                            hintText: 'Enter new weight, kg',
                            borderRadius: 25.w,
                            isFill: true,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: AppSpace.spaceMedium),
                        CustomButton(
                          onPressed: _addWeight,
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
            ),

            // Journal Title
            SizedBox(height: AppSpace.spaceMedium),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
              child: Text(
                'Journal',
                style: AppTextStyle.textH2Style.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Column Headers
            SizedBox(height: AppSpace.spaceSmall),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Weight',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Gain',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Week',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  )
                ],
              ),
            ),

            // Journal List
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpace.spaceMedium,
                ),
                child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(height: 1),
                  itemCount: _journalEntries.length,
                  itemBuilder: (context, index) {
                    final entry = _journalEntries[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppSpace.spaceSmall,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(entry['date']!)),
                          Expanded(child: Text(entry['weight']!)),
                          Expanded(
                            child: Text(
                              entry['gain']!,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          Expanded(child: Text(entry['week']!)),
                          IconImageWidget(
                            iconImagePath: AppIcons.ic_right,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
