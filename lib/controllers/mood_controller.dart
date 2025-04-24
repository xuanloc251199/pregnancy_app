import 'package:get/get.dart';
import '../models/mood_entry.dart';

class MoodTrackerController extends GetxController {
  final moods = [
    'Happiness',
    'Joy',
    'Excitement',
    'Satisfaction',
    'Love',
    'Gratitude',
    'Affection',
    'Enthusiasm',
    'Cheerful',
    'Contentment',
    'Frustration',
    'Fear',
    'Surprise',
    'Sadness',
    'Anger',
    'Pain',
    'Boredom',
    'Indifference'
  ];
  final moodColors = {
    'Happiness': 'positive',
    'Joy': 'positive',
    'Excitement': 'positive',
    'Satisfaction': 'positive',
    'Love': 'positive',
    'Gratitude': 'positive',
    'Affection': 'positive',
    'Enthusiasm': 'positive',
    'Cheerful': 'positive',
    'Contentment': 'positive',
    'Frustration': 'negative',
    'Fear': 'negative',
    'Surprise': 'negative',
    'Sadness': 'negative',
    'Anger': 'negative',
    'Pain': 'negative',
    'Boredom': 'neutral',
    'Indifference': 'neutral'
  };

  var selected = <String>[].obs;
  var journal = <MoodEntry>[].obs;

  void toggleMood(String mood) {
    if (selected.contains(mood)) {
      selected.remove(mood);
    } else {
      selected.add(mood);
    }
  }

  void saveMood() {
    if (selected.isNotEmpty) {
      journal.insert(
          0, MoodEntry(time: DateTime.now(), emotions: List.from(selected)));
      selected.clear();
    }
  }
}
