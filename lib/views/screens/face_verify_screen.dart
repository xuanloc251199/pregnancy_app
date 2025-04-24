// import 'package:camera/camera.dart';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pregnancy_app/controllers/event_controller.dart';
// import 'package:pregnancy_app/controllers/face_verify_controller.dart';
// import 'package:pregnancy_app/resources/icons.dart';
// import 'package:pregnancy_app/resources/spaces.dart';
// import 'package:pregnancy_app/resources/strings.dart';
// import 'package:pregnancy_app/styles/_text_header_style.dart';
// import 'package:pregnancy_app/views/layouts/custom_header.dart';
// import 'package:pregnancy_app/views/widgets/custom_button.dart';

// class FaceVerifyScreen extends StatelessWidget {
//   final FaceVerifyController controller = Get.put(FaceVerifyController());
//   final EventController eventController = Get.put(EventController());

//   @override
//   Widget build(BuildContext context) {
//     final eventId = Get.arguments;
//     print('Event Id: $eventId');
//     return Scaffold(
//       body: Obx(() {
//         if (!controller.isCameraInitialized.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(AppSpace.spaceMedium),
//                 child: CustomHeader(
//                   headerTitle: AppString.scanFace,
//                   isPreFixIcon: true,
//                   prefixIconImage: AppIcons.ic_back,
//                   prefixOnTap: () => Get.back(),
//                   isSuFixIcon: false,
//                 ),
//               ),
//               Stack(
//                 children: [
//                   Transform(
//                       alignment: Alignment.center,
//                       transform: Matrix4.rotationY(pi),
//                       child: CameraPreview(controller.cameraController!)),
//                   Positioned(
//                     bottom: 50,
//                     left: 0,
//                     right: 0,
//                     child: Padding(
//                       padding: EdgeInsets.all(AppSpace.spaceMedium),
//                       child: Column(
//                         children: [
//                           Text(
//                             controller.statusMessage.value,
//                             style: AppTextStyle.textTitle1Style,
//                           ),
//                           SizedBox(
//                             height: AppSpace.spaceMedium,
//                           ),
//                           CustomButton(
//                             text: 'Verify Face',
//                             onPressed: () {
//                               if (eventId != '') {
//                                 controller.captureAndVerifyFace(eventId!);
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
