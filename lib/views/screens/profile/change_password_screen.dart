import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pregnancy_app/controllers/profile_controller.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/layouts/custom_header.dart';
import 'package:pregnancy_app/views/widgets/custom_text_field_widget.dart';
import '../../../resources/icons.dart';
import '../../widgets/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  // Rx để phản ứng ẩn/hiện password
  final RxBool showOldPass = false.obs;
  final RxBool showNewPass = false.obs;
  final RxBool showConfirmPass = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpace.spaceMain),
                CustomHeader(
                  headerTitle: 'Password Manager',
                  isPreFixIcon: true,
                  prefixOnTap: () => Get.back(),
                  isSuFixIcon: false,
                  prefixIconImage: AppIcons.ic_back,
                ),
                SizedBox(height: 26),
                // Current Password
                Obx(() => CustomTextFieldWidget(
                      hintText: "Enter your current password",
                      isLabel: true,
                      label: 'Current Password',
                      labelStyle: AppTextStyle.textTitle3Style,
                      controller: oldPassController,
                      obscureText: !showOldPass.value,
                      suffixImage: showOldPass.value
                          ? AppIcons.ic_show
                          : AppIcons.ic_hiden,
                      onSuffixIconTap: () =>
                          showOldPass.value = !showOldPass.value,
                    )),
                SizedBox(height: 10),
                // New Password
                Obx(() => CustomTextFieldWidget(
                      hintText: "Create a new password",
                      isLabel: true,
                      label: 'New Password',
                      labelStyle: AppTextStyle.textTitle3Style,
                      controller: newPassController,
                      obscureText: !showNewPass.value,
                      suffixImage: showNewPass.value
                          ? AppIcons.ic_show
                          : AppIcons.ic_hiden,
                      onSuffixIconTap: () =>
                          showNewPass.value = !showNewPass.value,
                    )),
                SizedBox(height: 10),
                // Confirm New Password
                Obx(() => CustomTextFieldWidget(
                      hintText: "Re-enter your new password",
                      isLabel: true,
                      label: 'Confirm New Password',
                      labelStyle: AppTextStyle.textTitle3Style,
                      controller: confirmPassController,
                      obscureText: !showConfirmPass.value,
                      suffixImage: showConfirmPass.value
                          ? AppIcons.ic_show
                          : AppIcons.ic_hiden,
                      onSuffixIconTap: () =>
                          showConfirmPass.value = !showConfirmPass.value,
                    )),
                SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Obx(
                    () {
                      return controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : CustomButton(
                              text: "Change Password",
                              onPressed: () {
                                controller.changePassword(
                                  oldPassController.text.trim(),
                                  newPassController.text.trim(),
                                  confirmPassController.text.trim(),
                                );
                              },
                            );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
