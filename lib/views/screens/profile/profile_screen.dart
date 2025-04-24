import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: Obx(() {
    //       if (userController.isLoading.value) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       // final user = userController.userData;
    //       return Column(
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.symmetric(
    //               horizontal: AppSpace.spaceMedium,
    //               vertical: AppSpace.paddingMain,
    //             ),
    //             child: CustomHeader(
    //               isPreFixIcon: false,
    //               isSuFixIcon: true,
    //               sufixIconImage: AppIcons.ic_sign_out,
    //               sufixOnTap: () {
    //                 signOutController.signOut();
    //               },
    //               headerTitle: AppString.labelProfile,
    //               textStyle: AppTextStyle.textTitle1Style,
    //             ),
    //           ),
    //           // Profile Avatar và thông tin
    //           Column(
    //             children: [
    //               Center(
    //                 child: Obx(() {
    //                   return Container(
    //                     width: 100.px,
    //                     height: 100.px,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(50.px),
    //                       border: Border.all(
    //                         width: 2,
    //                         color: AppColors.primaryColor,
    //                       ),
    //                     ),
    //                     child: ClipRRect(
    //                       borderRadius: BorderRadius.circular(50.px),
    //                       child: userController.selectedAvatar.value != null
    //                           ? Image.file(
    //                               userController.selectedAvatar.value!,
    //                               width: 100.px,
    //                               height: 100.px,
    //                               fit: BoxFit.cover,
    //                             )
    //                           : (userController.userData['avatar'] != null &&
    //                                   userController
    //                                       .userData['avatar'].isNotEmpty
    //                               ? Image.network(
    //                                   userController.userData[
    //                                       'avatar'], // Hiển thị avatar từ URL
    //                                   width: 100.px,
    //                                   height: 100.px,
    //                                   fit: BoxFit.cover,
    //                                 )
    //                               : Image.network(
    //                                   AppImage.imgAvatarDefault,
    //                                   width: 100.px,
    //                                   height: 100.px,
    //                                   fit: BoxFit.cover,
    //                                 )),
    //                     ),
    //                   );
    //                 }),
    //               ),
    //               SizedBox(height: AppSpace.spaceMedium),
    //               Text(
    //                   // user['full_name'] ?? user['email'] ??
    //                   AppString.noAwswer,
    //                   style: AppTextStyle.textTitle1Style),
    //               SizedBox(height: AppSpace.spaceMedium),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.center,
    //               //   children: [
    //               //     _buildStatItem("350", "Following"),
    //               //     SizedBox(width: 40),
    //               //     _buildStatItem("346", "Followers"),
    //               //   ],
    //               // ),
    //               SizedBox(height: 12),
    //               CustomButtonActionIcon(
    //                 text: AppString.editProfile,
    //                 iconImage: AppIcons.ic_edit,
    //                 isPrimary: false,
    //                 onPreesed: () {
    //                   Get.toNamed(AppRoutes.editProfile);
    //                 },
    //               ),
    //               // Row(
    //               //   mainAxisAlignment: MainAxisAlignment.center,
    //               //   children: [
    //               //     _buildButton(AppString.follow, AppIcons.ic_follow, true),
    //               //     SizedBox(width: 10),
    //               //     _buildButton(AppString.titleMassage, AppIcons.ic_massage, false),
    //               //   ],
    //               // ),
    //               SizedBox(height: 12),
    //             ],
    //           ),
    //           // TabBar và TabBarView
    //           Expanded(
    //             child: DefaultTabController(
    //               length: 3,
    //               child: Column(
    //                 children: [
    //                   TabBar(
    //                     indicatorColor: AppColors.primaryColor,
    //                     labelColor: AppColors.primaryColor,
    //                     unselectedLabelColor: AppColors.textHintColor,
    //                     tabs: [
    //                       Tab(text: "ABOUT"),
    //                       Tab(text: "HISTORY APPOINTMENTS"),
    //                     ],
    //                   ),
    //                   Expanded(
    //                     child: TabBarView(
    //                       children: [
    //                         _buildAboutTab(),
    //                         _buildEventTab(),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //     }),
    //   ),
    // );
    return Placeholder();
  }
}
