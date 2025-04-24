import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/views/layouts/custom_header.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/baby_generator_controller.dart';
import '../../../resources/colors.dart';
import '../../../styles/_text_header_style.dart';
import '../../widgets/custom_button.dart';

class BabyGeneratorScreen extends StatelessWidget {
  final BabyGeneratorController controller = Get.put(BabyGeneratorController());

  Future<void> _pickImage({required bool isDad}) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      if (isDad) {
        controller.pickAndUploadDadImage(File(picked.path));
      } else {
        controller.pickAndUploadMomImage(File(picked.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            CustomHeader(
              headerTitle: 'Baby Generator',
              isPreFixIcon: false,
              isSuFixIcon: false,
            ),
            SizedBox(
              height: AppSpace.spaceMain,
            ),
            Expanded(
              child: Obx(() {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSpace.spaceMain),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ParentImagePicker(
                              title: "Dad Image",
                              imageUrl: controller.dadImageUrl.value,
                              onTap: () => _pickImage(isDad: true),
                            ),
                            _ParentImagePicker(
                              title: "Mom Image",
                              imageUrl: controller.momImageUrl.value,
                              onTap: () => _pickImage(isDad: false),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpace.spaceMedium),
                        // Chọn giới tính
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              text: 'Bé Trai',
                              onPressed: () =>
                                  controller.gender.value = 'babyBoy',
                              selected: controller.gender.value == 'babyBoy',
                              isFill: controller.gender.value == 'babyBoy'
                                  ? true
                                  : false,
                              backgroundColor: AppColors.primaryColor,
                              textStyle: AppTextStyle.textButtonStyle.copyWith(
                                color: controller.gender.value == 'babyBoy'
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                              width: 110,
                              height: 42,
                              radius: 12,
                              isUppercase: false,
                              elevation:
                                  controller.gender.value == 'babyBoy' ? 2 : 0,
                            ),
                            SizedBox(width: 20),
                            CustomButton(
                              text: 'Bé Gái',
                              onPressed: () =>
                                  controller.gender.value = 'babyGirl',
                              selected: controller.gender.value == 'babyGirl',
                              isFill: controller.gender.value == 'babyGirl'
                                  ? true
                                  : false,
                              backgroundColor: AppColors.primaryColor,
                              textStyle: AppTextStyle.textButtonStyle.copyWith(
                                color: controller.gender.value == 'babyGirl'
                                    ? Colors.white
                                    : AppColors.primaryColor,
                              ),
                              width: 110.px,
                              height: 42.px,
                              isUppercase: false,
                              elevation:
                                  controller.gender.value == 'babyGirl' ? 2 : 0,
                            ),
                          ],
                        ),
                        SizedBox(height: AppSpace.spaceMain),
                        // Nút tạo ảnh
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: CustomButton(
                            text: "Tạo Ảnh Em Bé AI",
                            onPressed: controller.isLoading.value
                                ? null
                                : () => controller.generateBaby(),
                            isDisabled: controller.isLoading.value,
                            isFill: true,
                            elevation: 2,
                            child: controller.isLoading.value
                                ? SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(height: AppSpace.spaceMain),
                        // Kết quả
                        if (controller.babyImageUrl.value.isNotEmpty)
                          Column(
                            children: [
                              Text(
                                'Your Baby',
                                style: AppTextStyle.textTitle1Style,
                              ),
                              SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  controller.babyImageUrl.value,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParentImagePicker extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const _ParentImagePicker(
      {required this.title, required this.imageUrl, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey.shade200,
            backgroundImage:
                imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
            child: imageUrl.isEmpty
                ? Icon(Icons.add_a_photo, size: 32, color: Colors.grey)
                : null,
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const GenderButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: label,
      onPressed: onTap,
      isFill: selected,
      backgroundColor: selected ? AppColors.primaryColor : Colors.white,
      borderColor: AppColors.primaryColor,
      textStyle: AppTextStyle.textButtonStyle.copyWith(
        color: selected ? Colors.white : AppColors.primaryColor,
      ),
      width: 110, // Hoặc tuỳ ý, ví dụ 40.w nếu dùng sizer
      height: 42, // Tuỳ ý chiều cao
      radius: 12,
      isUppercase: false,
      elevation: selected ? 2 : 0,
    );
  }
}
