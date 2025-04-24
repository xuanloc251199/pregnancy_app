import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pregnancy_app/controllers/profile_controller.dart';
import 'package:pregnancy_app/resources/colors.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final user = controller.user.value ?? {};
    nameController = TextEditingController(text: user['name'] ?? '');
    phoneController = TextEditingController(text: user['phone'] ?? '');
    emailController = TextEditingController(text: user['email'] ?? '');
    addressController = TextEditingController(text: user['address'] ?? '');
    controller.avatarFile.value = null; // reset khi vào screen
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = controller.user.value?['avatar_url'] ??
        "https://placehold.jp/cccccc/ffffff/150x150.png?text=Avatar";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: AppColors.primaryColor),
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          children: [
            SizedBox(height: 8),
            Obx(() => Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: AppColors.primaryColor.withAlpha(30),
                      backgroundImage: controller.avatarFile.value != null
                          ? FileImage(controller.avatarFile.value!)
                          : NetworkImage(avatarUrl) as ImageProvider,
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () async {
                          final picked = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (picked != null) {
                            controller.avatarFile.value = File(picked.path);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child:
                              Icon(Icons.edit, size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 24),
            _LabeledField(
              label: 'Name',
              child: TextField(
                controller: nameController,
                decoration: _inputDecoration(),
              ),
            ),
            SizedBox(height: 18),
            _LabeledField(
              label: 'Phone Number',
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: _inputDecoration(),
              ),
            ),
            SizedBox(height: 18),
            _LabeledField(
              label: 'Email',
              child: TextField(
                controller: emailController,
                enabled: false,
                decoration: _inputDecoration(
                    hint: "example@domainname.com",
                    fillColor: Colors.grey.shade100),
              ),
            ),
            SizedBox(height: 18),
            _LabeledField(
              label: 'Address',
              child: TextField(
                controller: addressController,
                decoration: _inputDecoration(),
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  controller.updateProfile(
                    name: nameController.text.trim(),
                    address: addressController.text.trim(),
                    phone: phoneController.text.trim(),
                    avatar: controller.avatarFile.value,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  "Update Profile",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint, Color? fillColor}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: fillColor ?? Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        SizedBox(height: 5),
        child,
      ],
    );
  }
}
