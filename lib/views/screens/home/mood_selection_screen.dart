// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controllers/mood_controller.dart';
// import 'mood_journal_screen.dart';

// class MoodSelectionScreen extends StatelessWidget {
//   final MoodController controller = Get.put(MoodController());

//   final List<String> positiveMoods = [
//     'Happiness',
//     'Joy',
//     'Excitement',
//     'Satisfaction',
//     'Love',
//     'Gratitude',
//     'Affection',
//     'Enthusiasm',
//     'Cheerful',
//     'Contentment',
//   ];

//   final List<String> negativeMoods = [
//     'Frustration',
//     'Fear',
//     'Surprise',
//     'Sadness',
//     'Anger',
//     'Pain',
//   ];

//   final List<String> neutralMoods = ['Boredom', 'Indifference'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFDEFFF),
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 'How are you feeling right now?',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Obx(() => Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: [
//                         ..._buildMoodChips(positiveMoods, Colors.green),
//                         ..._buildMoodChips(negativeMoods, Colors.red),
//                         ..._buildMoodChips(neutralMoods, Colors.orange),
//                       ],
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   controller.saveSelectedMoods();
//                   Get.to(() => MoodJournalScreen());
//                 },
//                 icon: Icon(Icons.arrow_forward),
//                 label: Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   shape: StadiumBorder(),
//                   backgroundColor: Colors.blue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildMoodChips(List<String> moods, Color borderColor) {
//     return moods.map((mood) {
//       final isSelected = controller.selectedMoods.contains(mood);
//       return ChoiceChip(
//         label: Text(mood),
//         selected: isSelected,
//         selectedColor: borderColor.withOpacity(0.1),
//         backgroundColor: Colors.white,
//         shape: StadiumBorder(side: BorderSide(color: borderColor)),
//         labelStyle: TextStyle(
//           color: isSelected ? borderColor : Colors.black,
//           fontWeight: FontWeight.w500,
//         ),
//         onSelected: (_) => controller.toggleMood(mood),
//       );
//     }).toList();
//   }

//   Widget _buildHeader() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFDDEBFF),
//         borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: const [
//           Icon(Icons.arrow_back_ios, color: Colors.black),
//           SizedBox(width: 8),
//           Text(
//             'Mood Tracker',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           Spacer(),
//           Icon(Icons.person, size: 48),
//         ],
//       ),
//     );
//   }
// }
