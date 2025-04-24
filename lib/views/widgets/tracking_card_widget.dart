// weight_tracker_icon.dart
import 'package:flutter/material.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';
import 'package:sizer/sizer.dart';

class TrackingCardWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color backgroundColor;
  final GestureTapCallback? onTap;

  const TrackingCardWidget(
      {Key? key,
      required this.title,
      required this.imagePath,
      required this.backgroundColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20), // cùng với Container
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  imagePath,
                  width: 35.w,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(title, style: AppTextStyle.textTitle1DarkStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
