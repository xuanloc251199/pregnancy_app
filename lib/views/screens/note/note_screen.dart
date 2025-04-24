import 'package:flutter/material.dart';

import '../../../resources/icons.dart';
import '../../../resources/spaces.dart';
import '../../../resources/strings.dart';
import '../../../styles/_text_header_style.dart';
import '../../layouts/custom_header.dart';

class NoteScreen extends StatefulWidget {
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  // Selected week index (starting from week 1)
  int selectedWeek = 8;

  // You can customize this data or fetch it dynamically
  final int currentTrimester = 1;
  final String laborDate = '07-Jul-2024';
  final int totalPregnancyWeeks = 40; // Standard pregnancy length in weeks
  final int currentPregnancyWeek = 7;
  final int currentPregnancyDays = 3;

  @override
  Widget build(BuildContext context) {
    // Calculate weeks left
    int weeksLeft = totalPregnancyWeeks -
        currentPregnancyWeek -
        ((currentPregnancyDays >= 7) ? 1 : 0);
    int daysLeft = (7 - currentPregnancyDays) % 7;

    return Scaffold(
      backgroundColor: const Color(0xFFF9C8C3), // background peach color
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpace.spaceMedium,
                vertical: AppSpace.paddingMain,
              ),
              child: CustomHeader(
                isPreFixIcon: false,
                isSuFixIcon: false,
                sufixIconImage: AppIcons.ic_sign_out,
                headerTitle: AppString.labelNote,
                textStyle: AppTextStyle.textTitle1Style,
              ),
            ),
            // Top info boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoBox(title: '1g', subtitle: 'weight'),
                  _InfoBox(title: '1.6 cm', subtitle: 'length'),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Baby embryo image container
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  'assets/images/baby_asset.png',
                  width: 130,
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Week selector
            Container(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  int week = index + 1;
                  bool isSelected = week == selectedWeek;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWeek = week;
                      });
                    },
                    child: Container(
                      width: 42,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.transparent,
                        border: Border.all(
                          color: Colors.deepOrangeAccent,
                          width: 1.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$week',
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.deepOrangeAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 12),

            Text(
              'current week',
              style: TextStyle(
                color: Colors.deepOrangeAccent.shade700,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 20),

            // Bottom card containing trimester and labor date info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFB95D5D),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$currentPregnancyWeek weeks and $currentPregnancyDays days',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$currentTrimester trimester',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '$weeksLeft weeks and $daysLeft days left',
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date of labor $laborDate',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // Info expandable cards
            Expanded(
              flex: 5,
              child: Container(
                color: const Color(0xFFB95D5D),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      _InfoCard(
                        title: 'Baby',
                        content:
                            'In week 8 the embryo looks more and more like a human, instead of an alien. The head is about half of the entire body length. The little face continues to',
                        onTap: () {
                          // Add navigation or detail action
                        },
                      ),
                      SizedBox(height: 10),
                      _InfoCard(
                        title: 'Mom',
                        content:
                            'In week 8, people around you still won\'t notice your growing belly, but you might find yourself having trouble buttoning your favorite tight jeans. Close-',
                        onTap: () {
                          // Add navigation or detail action
                        },
                      ),
                      SizedBox(height: 10),
                      _InfoCard(
                        title: 'Useful advice',
                        content:
                            'Of course, we\'re talking about a normally-progressing pregnancy, with no complications. If that\'s the case, sex is definitely allowed',
                        onTap: () {
                          // Add navigation or detail action
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const _InfoBox({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 88,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onTap;

  const _InfoCard({
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD67070),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.white70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
