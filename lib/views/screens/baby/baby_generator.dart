import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/views/widgets/custom_button.dart';
import '../../../resources/spaces.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';

class BabyGeneratorController extends GetxController {
  var gender = 'Random'.obs;

  void updateGender(String? newGender) {
    if (newGender != null) {
      gender.value = newGender;
    }
  }

  void generateBaby() {
    print('Generate baby with gender: ${gender.value}');
    // Implement your baby generation logic here
  }
}

class BabyGeneratorScreen extends StatelessWidget {
  final BabyGeneratorController controller = Get.put(BabyGeneratorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpace.spaceMedium,
                vertical: AppSpace.paddingMain,
              ),
              child: CustomHeader(
                isPreFixIcon: false,
                isSuFixIcon: false,
                headerTitle: 'Baby Generator',
                textStyle: AppTextStyle.textTitle1Style,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildParentPhotoSection(1),
                  SizedBox(height: 2.h),
                  _buildParentPhotoSection(2),
                  SizedBox(height: 2.h),
                  _buildGenderSelector(),
                  SizedBox(height: 2.h),
                  CustomButton(
                    onPressed: controller.generateBaby,
                    text: 'Generate',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParentPhotoSection(int parentNumber) {
    return Container(
      padding: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('Parent $parentNumber Photo',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1.h),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.upload),
            label: Text('Upload'),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Obx(() {
      return Column(
        children: [
          Text('Baby gender', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: controller.gender.value,
            items: <String>['Random', 'Boy', 'Girl'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              controller.updateGender(newValue);
            },
          ),
        ],
      );
    });
  }
}
