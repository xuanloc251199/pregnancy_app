import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/resources/sizes.dart';
import 'package:pregnancy_app/resources/spaces.dart';
import 'package:pregnancy_app/styles/_button_style.dart';
import 'package:pregnancy_app/styles/_text_header_style.dart';

class CustomAnimationDialog extends StatelessWidget {
  final String title;
  final String lottieIconLink;
  final TextStyle? textStyle;
  final Function()? onPreesed;

  const CustomAnimationDialog({
    super.key,
    required this.title,
    this.onPreesed,
    required this.lottieIconLink,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPreesed,
      child: Container(
        color: Colors.black54,
        child: Center(
          child: Container(
            height: 20.h,
            padding: EdgeInsets.all(AppSizes.brMain),
            margin: EdgeInsets.symmetric(horizontal: AppSpace.spaceMain),
            decoration: AppButtonStyle.buttonShadowDecor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Lottie.network(lottieIconLink,
                      width: 80.px, height: 80.px),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: textStyle ?? AppTextStyle.textBody3Style,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
