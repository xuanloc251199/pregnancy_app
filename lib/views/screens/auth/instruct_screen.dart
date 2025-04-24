// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pregnancy_app/resources/colors.dart';
// import 'package:pregnancy_app/resources/icons.dart';
// import 'package:pregnancy_app/resources/images.dart';
// import 'package:pregnancy_app/resources/spaces.dart';
// import 'package:pregnancy_app/resources/strings.dart';
// import 'package:pregnancy_app/routes/app_route.dart';
// import 'package:pregnancy_app/styles/_text_header_style.dart';
// import 'package:pregnancy_app/views/layouts/custom_header.dart';
// import 'package:pregnancy_app/views/screens/auth/add_information_screen.dart';
// import 'package:pregnancy_app/views/screens/profile/qr_scan_screen.dart';
// import 'package:pregnancy_app/views/widgets/custom_button.dart';

// class InstructScreen extends StatelessWidget {
//   final RxMap<String, String> scannedData = RxMap<String, String>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(AppSpace.spaceMedium),
//           child: Column(
//             children: [
//               CustomHeader(
//                 headerTitle: AppString.addInformation,
//                 isPreFixIcon: true,
//                 prefixIconImage: AppIcons.ic_back,
//                 prefixOnTap: Get.back,
//                 isSuFixIcon: true,
//                 sufixIconImage: AppIcons.ic_close,
//                 sufixOnTap: () {
//                   Get.offAllNamed(AppRoutes.base);
//                 },
//               ),
//               Padding(
//                 padding: EdgeInsets.all(AppSpace.spaceLarge),
//                 child: Image.asset(AppImage.addInfor),
//               ),
//               Expanded(
//                 child: ListView(
//                   children: [
//                     _buildStepItem('1', 'Quét QR CCCD để kết nối thông tin'),
//                     _buildStepItem('3', 'Chụp ảnh khuôn mặt'),
//                     _buildStepItem('4', 'Xác nhận thông tin và hoàn tất'),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               CustomButton(
//                 text: 'Bắt đầu cập nhật',
//                 onPressed: () async {
//                   // Chuyển đến màn hình quét QR
//                   final result = await Get.toNamed(AppRoutes.qrScan,
//                       arguments: AppRoutes.addInfor);

//                   // Nếu nhận được dữ liệu từ màn hình QR Scan
//                   if (result != null && result is String) {
//                     Get.toNamed(AppRoutes.qrScan,
//                         arguments: AppRoutes.addInfor);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStepItem(String stepNumber, String description) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             radius: 14,
//             backgroundColor: AppColors.primaryColor,
//             child: Text(
//               stepNumber,
//               style: AppTextStyle.textButtonStyle,
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               description,
//               style: AppTextStyle.textTitle3Style,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
