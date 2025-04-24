import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:pregnancy_app/resources/colors.dart';

import '../../resources/sizes.dart';
import '../../styles/_text_header_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final Color? borderColor;
  final double elevation;
  final double? width;
  final double? height;
  final double? radius;
  final bool isFill;
  final bool isUppercase;
  final bool isDisabled;
  final bool selected; // toggle hoặc action đều dùng được
  final TextStyle? textStyle;
  final TextStyle? disabledTextStyle;
  final Widget?
      child; // cho phép custom child (ví dụ CircularProgressIndicator)

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.disabledBackgroundColor,
    this.elevation = 5.0,
    this.width,
    this.height,
    this.isFill = true,
    this.textStyle,
    this.disabledTextStyle,
    this.radius,
    this.isUppercase = true,
    this.borderColor,
    this.isDisabled = false,
    this.selected = false,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor = isDisabled
        ? (disabledBackgroundColor ?? AppColors.iconGreyColor)
        : selected
            ? (backgroundColor ?? AppColors.primaryColor)
            : (isFill ? (backgroundColor ?? Colors.white) : Colors.transparent);
    final Color effectiveBorderColor = isDisabled
        ? AppColors.hidenBackgroundColor
        : (borderColor ?? AppColors.primaryColor);
    final Color effectiveTextColor = isDisabled
        ? AppColors.whiteColor.withOpacity(0.6)
        : selected
            ? Colors.white
            : (textStyle?.color ?? AppColors.primaryColor);

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        height: height ?? 60.px,
        width: width ?? double.infinity,
        decoration: isFill
            ? BoxDecoration(
                color: effectiveBackgroundColor,
                borderRadius: BorderRadius.circular(radius ?? AppSizes.brMain),
                border: Border.all(
                  width: 1,
                  color: effectiveBorderColor,
                ),
                boxShadow: isDisabled
                    ? null
                    : selected
                        ? [
                            BoxShadow(
                              color:
                                  AppColors.secondPrimaryColor.withOpacity(0.1),
                              offset: Offset(0, elevation),
                              blurRadius: elevation * 2,
                              spreadRadius: 0.5,
                            ),
                          ]
                        : [],
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(radius ?? AppSizes.brMain),
                border: Border.all(
                  width: 1,
                  color: effectiveBorderColor,
                ),
              ),
        child: Center(
          child: child ??
              Text(
                isUppercase ? text.toUpperCase() : text,
                textAlign: TextAlign.center,
                style: isDisabled
                    ? (disabledTextStyle ??
                        AppTextStyle.textButtonStyle.copyWith(
                          color: AppColors.whiteColor.withOpacity(0.6),
                        ))
                    : (textStyle ??
                        AppTextStyle.textButtonStyle.copyWith(
                          color: isFill
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        )),
              ),
        ),
      ),
    );
  }
}
