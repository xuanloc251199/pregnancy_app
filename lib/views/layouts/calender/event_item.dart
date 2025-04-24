// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:pregnancy_app/controllers/event_controller.dart';
// import 'package:pregnancy_app/resources/images.dart';
// import 'package:pregnancy_app/views/widgets/custom_button_icon.dart';
// import '../../../models/event.dart';
// import '../../../resources/colors.dart';
// import '../../../resources/icons.dart';
// import '../../../resources/sizes.dart';
// import '../../../resources/spaces.dart';
// import '../../../styles/_text_header_style.dart';
// import '../../widgets/icon_image_widget.dart';

// class EventItem extends StatelessWidget {
//   final int index;
//   final bool isRecommendation;
//   final bool isUpcoming;

//   const EventItem({
//     super.key,
//     required this.index,
//     this.isRecommendation = false,
//     this.isUpcoming = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final eventController = Get.find<EventController>();

//     // Kiểm tra danh sách sự kiện
//     final event = isRecommendation
//         ? eventController.recommendEvents[index]
//         : isUpcoming
//             ? eventController.upcomingEvents[index]
//             : eventController.events[index];

//     return GestureDetector(
//       onTap: () {
//         eventController.navigateToEventDetail(event.id);
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 20, bottom: 5.h),
//         width: 238.px,
//         decoration: BoxDecoration(
//           color: AppColors.backgroundWhiteColor,
//           borderRadius: BorderRadius.circular(AppSizes.brListItem),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryShadowColor,
//               spreadRadius: 2,
//               blurRadius: AppSizes.brMain,
//               offset: const Offset(5, 5),
//             )
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildThumbnail(event),
//               _buildEventDetails(event),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildThumbnail(Event event) {
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 131.px,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(AppSizes.brMain),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(AppSizes.brMain),
//             child: Image.network(
//               event.thumbnail ?? AppImage.imgEventDefault,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               _buildDateContainer(event),
//               _buildBookmarkIcon(),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildDateContainer(Event event) {
//     return Container(
//       width: 68.px,
//       height: 45.px,
//       decoration: BoxDecoration(
//         color: AppColors.backgroundWhiteColor.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             event.day,
//             style: AppTextStyle.textButtonHighlightStyle,
//           ),
//           Text(
//             event.monthName.toUpperCase(),
//             style: AppTextStyle.textSubTitle3Style,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookmarkIcon() {
//     return CustomButtonIcon(
//       iconImagePath: AppIcons.ic_bookmark_f,
//       width: 30.px,
//       height: 30.px,
//       backgroundColor: AppColors.backgroundWhiteColor.withOpacity(0.7),
//     );
//   }

//   Widget _buildEventDetails(Event event) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             event.title,
//             style: AppTextStyle.textTitle2Style,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(height: AppSpace.spaceSmall),
//           _buildRegistrationInfo(event),
//           SizedBox(height: AppSpace.spaceSmallW),
//           _buildLocationInfo(event),
//         ],
//       ),
//     );
//   }

//   Widget _buildRegistrationInfo(Event event) {
//     if (event.registrations.isNotEmpty) {
//       return Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           _buildAvatarStack(event),
//           if (event.registrations.length > 3)
//             Text(
//               "+${event.registrations.length - 3} Going",
//               style: AppTextStyle.textHighlightBody,
//             ),
//         ],
//       );
//     } else {
//       return Text(
//         'Nobody register yet',
//         style: AppTextStyle.textHighlightBody,
//       );
//     }
//   }

//   Widget _buildAvatarStack(Event event) {
//     return Container(
//       height: 30.px,
//       width: 65.px,
//       child: Stack(
//         children: [
//           for (int i = 0;
//               i <
//                   (event.registrations.length > 3
//                       ? 3
//                       : event.registrations.length);
//               i++)
//             Positioned(
//               left: i * 16.0,
//               child: Container(
//                 height: 24,
//                 width: 24,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12.px),
//                   child: Image.network(
//                     event.registrations[i].avatar.isNotEmpty
//                         ? event.registrations[i].avatar
//                         : AppImage.imgAvatarDefault,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocationInfo(Event event) {
//     return Row(
//       children: [
//         IconImageWidget(
//           iconImagePath: AppIcons.ic_calendar,
//           width: 15.px,
//         ),
//         SizedBox(width: AppSpace.spaceSmall),
//         Expanded(
//           child: Text(
//             event.location,
//             style: AppTextStyle.textSubTitle1Style,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
