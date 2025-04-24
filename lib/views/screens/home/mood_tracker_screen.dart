import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  final List<String> positiveMoods = [
    'Happiness',
    'Joy',
    'Excitement',
    'Satisfaction',
    'Love',
    'Gratitude',
    'Affection',
    'Enthusiasm',
    'Cheerful',
    'Contentment'
  ];

  final List<String> negativeMoods = [
    'Frustration',
    'Fear',
    'Surprise',
    'Sadness',
    'Anger',
    'Pain'
  ];

  final List<String> neutralMoods = ['Boredom', 'Indifference'];

  String? selectedMood;
  final List<Map<String, String>> moodJournal = [];

  void saveMood() {
    if (selectedMood != null) {
      setState(() {
        moodJournal.insert(0, {
          'date': DateFormat('dd MMM HH:mm').format(DateTime.now()),
          'mood': selectedMood!,
        });
        selectedMood = null;
      });
    }
  }

  Widget buildMoodChip(String mood, Color color) {
    final isSelected = selectedMood == mood;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = mood;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? color : color.withOpacity(0.6),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
        ),
        child: Text(
          mood,
          style: TextStyle(
            color: isSelected ? color : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFBEAFF), // light pink background
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFE5E9FF), // light blue
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back_ios_new, size: 20),
                  const SizedBox(width: 10),
                  const Text(
                    'Mood Tracker',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Image.asset('assets/images/yoga.png', height: 60),
                ],
              ),
            ),

            // Mood Chips
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How are you feeling right now?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      children: positiveMoods
                          .map((mood) => buildMoodChip(mood, Colors.green))
                          .toList(),
                    ),
                    Wrap(
                      children: negativeMoods
                          .map((mood) => buildMoodChip(mood, Colors.red))
                          .toList(),
                    ),
                    Wrap(
                      children: neutralMoods
                          .map((mood) => buildMoodChip(mood, Colors.orange))
                          .toList(),
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: saveMood,
                      child: Container(
                        width: width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Save',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Journal Section
            if (moodJournal.isNotEmpty) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Date and time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Emotions',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shrinkWrap: true,
                  itemCount: moodJournal.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final entry = moodJournal[index];
                    final mood = entry['mood']!;
                    Color moodColor = Colors.grey;

                    if (positiveMoods.contains(mood)) {
                      moodColor = Colors.green;
                    } else if (negativeMoods.contains(mood)) {
                      moodColor = Colors.red;
                    } else if (neutralMoods.contains(mood)) {
                      moodColor = Colors.orange;
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(index == 0
                            ? 'Today ${entry['date']!.split(' ')[1]}'
                            : entry['date']!),
                        Text(
                          mood,
                          style: TextStyle(
                              color: moodColor, fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
