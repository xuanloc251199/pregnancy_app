// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// import '../../../controllers/mood_controller.dart';

// class MoodJournalScreen extends StatelessWidget {
//   final MoodController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFDEFFF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: BackButton(color: Colors.black),
//         title: Text(
//           'Journal',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Obx(() => ListView.separated(
//             padding: const EdgeInsets.all(16),
//             itemCount: controller.moodJournal.length,
//             separatorBuilder: (_, __) => Divider(),
//             itemBuilder: (context, index) {
//               final entry = controller.moodJournal[index];
//               final time = entry['timestamp'] as DateTime;
//               final moods = entry['moods'] as List<String>;

//               return Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     time.day == DateTime.now().day
//                         ? 'Today ${DateFormat.Hm().format(time)}'
//                         : DateFormat('dd MMM HH:mm').format(time),
//                     style: TextStyle(color: Colors.grey[700]),
//                   ),
//                   Text(
//                     moods.join(', '),
//                     style: TextStyle(
//                       color: moods.contains('Cheerful')
//                           ? Colors.green
//                           : moods.contains('Boredom')
//                               ? Colors.orange
//                               : Colors.red,
//                     ),
//                   ),
//                 ],
//               );
//             },
//           )),
//     );
//   }
// }
