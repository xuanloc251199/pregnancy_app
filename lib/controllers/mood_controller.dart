import 'package:get/get.dart';

class MoodController extends GetxController {
  final RxList<String> selectedMoods = <String>[].obs;
  final RxList<Map<String, dynamic>> moodJournal = <Map<String, dynamic>>[].obs;

  void toggleMood(String mood) {
    if (selectedMoods.contains(mood)) {
      selectedMoods.remove(mood);
    } else {
      selectedMoods.add(mood);
    }
  }

  void saveSelectedMoods() {
    if (selectedMoods.isNotEmpty) {
      moodJournal.insert(0, {
        'timestamp': DateTime.now(),
        'moods': List<String>.from(selectedMoods),
      });
      selectedMoods.clear();
    }
  }
}
