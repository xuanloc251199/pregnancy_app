import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pregnancy_app/controllers/auth_controller.dart';
import 'package:pregnancy_app/controllers/profile_controller.dart';
import 'package:pregnancy_app/resources/colors.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/resources/strings.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:pregnancy_app/views/layouts/custom_header.dart';

import '../../../resources/icons.dart';
import '../../../routes/app_route.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ProfileController controller = Get.put(ProfileController());

  // Thêm trường đổi tên
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Danh sách menu
    final List<_ProfileMenuItem> menuItems = [
      _ProfileMenuItem(
        title: "Profile",
        icon: Icons.person_outline,
        onTap: () {
          Get.toNamed(AppRoutes.updateProfile);
        },
      ),
      _ProfileMenuItem(
          title: "Favourite", icon: Icons.favorite_border, onTap: null),
      _ProfileMenuItem(
          title: "Help Center", icon: Icons.help_outline, onTap: null),
      _ProfileMenuItem(
          title: "Privacy Policy",
          icon: Icons.privacy_tip_outlined,
          onTap: null),
      _ProfileMenuItem(
          title: "Settings", icon: Icons.settings_outlined, onTap: null),
      _ProfileMenuItem(
          title: "Payment Options",
          icon: Icons.credit_card_outlined,
          onTap: null),
      _ProfileMenuItem(
        title: "Password Manager",
        icon: Icons.lock_outline,
        onTap: () {
          Get.toNamed(AppRoutes.changePassword);
        },
      ),
      _ProfileMenuItem(
          title: "Log out",
          icon: Icons.logout,
          isLogout: true,
          onTap: () {
            AuthController().logout();
          }),
    ];

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final user = controller.user.value;
        if (user == null) {
          return Center(child: Text("Không có dữ liệu user"));
        }
        nameController.text = user['name'] ?? '';
        final avatarUrl = user['avatar_url'] ??
            "https://placehold.jp/cccccc/ffffff/150x150.png?text=Avatar";
        final userName = user['name'] ?? "";

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSpace.spaceMedium,
                    horizontal: AppSpace.spaceMedium,
                  ),
                  child: CustomHeader(
                    isPreFixIcon: true,
                    isSuFixIcon: false,
                    prefixIconImage: AppIcons.ic_back,
                    prefixOnTap: () => Get.back(),
                    headerTitle: AppString.labelProfile,
                    textStyle: AppTextStyle.textTitle1Style,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primaryColor.withAlpha(30),
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 6,
                        child: InkWell(
                          onTap: () async {
                            final picked = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (picked != null) {
                              controller.updateProfile(
                                  avatar: File(picked.path));
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child:
                                Icon(Icons.edit, size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpace.spaceMedium),
                  Text(
                    userName,
                    style: AppTextStyle.textTitle1Style.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: AppSpace.spaceMain),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = menuItems[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          item.icon,
                          color: AppColors.primaryColor,
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            color: item.isLogout ? Colors.red : Colors.black,
                            fontWeight: item.isLogout
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right, color: Colors.grey),
                        onTap: () {
                          if (item.isLogout) {
                            authController.logout();
                          } else if (item.onTap != null) {
                            item.onTap!();
                          }
                        },
                      ),
                      Divider(height: 1),
                    ],
                  );
                },
                childCount: menuItems.length,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: AppSpace.spaceMain)),
          ],
        );
      }),
    );
  }
}

// Class cho item menu
class _ProfileMenuItem {
  final String title;
  final IconData icon;
  final bool isLogout;
  final VoidCallback? onTap;

  _ProfileMenuItem({
    required this.title,
    required this.icon,
    this.isLogout = false,
    this.onTap,
  });
}
