// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:sizer/sizer.dart';
// import 'package:pregnancy_app/controllers/event_controller.dart';
// import 'package:pregnancy_app/models/event.dart';
// import 'package:pregnancy_app/resources/colors.dart';
// import 'package:pregnancy_app/resources/icons.dart';
// import 'package:pregnancy_app/resources/images.dart';
// import 'package:pregnancy_app/resources/sizes.dart';
// import 'package:pregnancy_app/resources/spaces.dart';
// import 'package:pregnancy_app/resources/strings.dart';
// import 'package:pregnancy_app/styles/_text_header_style.dart';
// import 'package:pregnancy_app/views/layouts/custom_header.dart';
// import 'package:pregnancy_app/views/widgets/custom_button.dart';
// import 'package:pregnancy_app/views/widgets/custom_button_icon.dart';

// class ContentSection extends StatelessWidget {
//   final Event event;
//   final EventController eventController;

//   const ContentSection({
//     super.key,
//     required this.event,
//     required this.eventController,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final coordinates = event.extractCoordinatesFromMapLink();
//     if (coordinates == null) {
//       return Text(
//         'Could not extract coordinates from map link',
//         style: AppTextStyle.textBody1Style,
//       );
//     }
//     return Stack(
//       children: [
//         Container(
//           margin: EdgeInsets.only(
//               bottom: AppSpace.spaceMedium * 2 + AppSizes.buttonHeight),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Image.network(
//                 event.thumbnail ?? AppImage.eventDefault,
//                 height: AppSizes.eventCoverHeight,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(
//                 height: AppSpace.spaceMain,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMedium),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       event.title,
//                       style: AppTextStyle.textH2Style,
//                     ),
//                     SizedBox(
//                       height: AppSpace.spaceMedium,
//                     ),
//                     Row(
//                       children: [
//                         CustomButtonIcon(
//                           iconImagePath: AppIcons.ic_calendar_f,
//                           width: 48.px,
//                           height: 48.px,
//                           backgroundColor: AppColors.primaryShadowColor,
//                           radius: AppSizes.brMain,
//                         ),
//                         SizedBox(
//                           width: AppSpace.spaceMedium,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               event.formattedDate,
//                               style: AppTextStyle.textBody1Style,
//                             ),
//                             Text(
//                               '${event.weekday} | ${event.formattedStartTime} - ${event.formattedEndTime}',
//                               style: AppTextStyle.textSubTitle2Style,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: AppSpace.spaceMedium,
//                     ),
//                     Row(
//                       children: [
//                         CustomButtonIcon(
//                           iconImagePath: AppIcons.ic_calendar,
//                           width: 48.px,
//                           height: 48.px,
//                           backgroundColor: AppColors.primaryShadowColor,
//                           radius: AppSizes.brMain,
//                         ),
//                         SizedBox(
//                           width: AppSpace.spaceMedium,
//                         ),
//                         Text(
//                           event.location,
//                           style: AppTextStyle.textBody1Style,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: AppSpace.spaceMedium,
//                     ),
//                     _buildMapView(event),
//                     SizedBox(
//                       height: AppSpace.spaceMain,
//                     ),
//                     Text(
//                       AppString.aboutEvent,
//                       style: AppTextStyle.textH4Style,
//                     ),
//                     SizedBox(
//                       height: AppSpace.spaceMedium,
//                     ),
//                     Text(
//                       event.description ?? AppString.noAwswer,
//                       style: AppTextStyle.textBody2Style,
//                     ),
//                     SizedBox(
//                       height: AppSpace.spaceMedium,
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//           child: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSpace.spaceMedium,
//                 vertical: AppSpace.paddingMain,
//               ),
//               child: CustomHeader(
//                 prefixOnTap: () => eventController.goBackScreen(),
//                 headerTitle: AppString.eventDetailTitle,
//                 textStyle: AppTextStyle.textTitle1DarkStyle,
//                 prefixIconImage: AppIcons.ic_back,
//                 prefixIconWidth: AppSizes.iconNavSize,
//                 prefixIconHeight: AppSizes.iconNavSize,
//                 prefixIconColor: AppColors.whiteColor,
//                 sufixIconImage: AppIcons.ic_calendar,
//                 sufixIconColor: AppColors.whiteColor,
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: AppSpace.spaceMain),
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     top: AppSizes.eventCoverHeight - AppSizes.buttonHeight / 2,
//                   ),
//                   height: AppSizes.buttonHeight,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(30.px),
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.buttonShadowColor,
//                         offset: Offset(0, 4),
//                         blurRadius: 4 * 2,
//                         spreadRadius: 0.5,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: AppSpace.spaceMedium,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         if (event.registrations.isNotEmpty) ...[
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 height: AppSizes.buttonHeight / 2,
//                                 width: 65.px,
//                                 child: Stack(
//                                   children: [
//                                     for (int i = 0;
//                                         i <
//                                             (event.registrations.length > 3
//                                                 ? 3
//                                                 : event.registrations.length);
//                                         i++)
//                                       Positioned(
//                                         left: i * 18.0,
//                                         child: Container(
//                                           height: 24,
//                                           width: 24,
//                                           child: CircleAvatar(
//                                             radius: 12,
//                                             backgroundImage: NetworkImage(
//                                               event.registrations[i].avatar
//                                                       .isNotEmpty
//                                                   ? event
//                                                       .registrations[i].avatar
//                                                   : AppImage
//                                                       .imgAvatarDefault, // URL mặc định nếu không có avatar
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               if (event.registrations.length > 3) ...[
//                                 Text(
//                                   "+${event.registrations.length > 3 ? event.registrations.length - 3 : 0} Going",
//                                   style: AppTextStyle.textHighlightBody,
//                                 ),
//                               ] else ...[
//                                 SizedBox.shrink(),
//                               ],
//                             ],
//                           ),
//                         ] else ...[
//                           Text(
//                             'No one register',
//                             style: AppTextStyle.textHighlightBody,
//                           )
//                         ],
//                         CustomButton(
//                           onPressed: () {
//                             eventController.showRegistrated();
//                           },
//                           width: 67.px,
//                           height: 25.px,
//                           text: AppString.seeAll,
//                           isUppercase: false,
//                           textStyle: AppTextStyle.textButtonSmallStyle,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMapView(Event event) {
//     final coordinates = event.extractCoordinatesFromMapLink();

//     if (coordinates == null) {
//       return Text(
//         'Could not extract coordinates from map link',
//         style: AppTextStyle.textBody1Style,
//       );
//     }

//     return Container(
//       height: 25.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(AppSizes.brMain),
//         border: Border.all(color: AppColors.primaryColor, width: 1.px),
//       ),
//       child: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: LatLng(coordinates['latitude']!, coordinates['longitude']!),
//           zoom: 15,
//         ),
//         markers: {
//           Marker(
//             markerId: MarkerId('event_location'),
//             position:
//                 LatLng(coordinates['latitude']!, coordinates['longitude']!),
//           ),
//         },
//       ),
//     );
//   }
// }
