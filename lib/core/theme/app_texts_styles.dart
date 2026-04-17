import 'package:bookia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle style({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    String? fontFamily,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    List<Shadow>? shadows,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      fontFamily: fontFamily,
      fontStyle: fontStyle,
      decoration: decoration,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      textBaseline: textBaseline,
      shadows: shadows,
    );
  }

  static final TextStyle title32Bold = style(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle title30Bold = style(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static final TextStyle title28Bold = style(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle title20Bold = style(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final TextStyle button16 = style(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle body14 = style(
    fontSize: 14.sp,
    color: AppColors.black,
  );

  static final TextStyle body14Gray = style(
    fontSize: 14.sp,
    color: AppColors.secondaryGray,
  );

  static final TextStyle body16Gray = style(
    fontSize: 16.sp,
    color: AppColors.secondaryGray,
  );

  static final TextStyle body16 = style(
    fontSize: 16.sp,
    color: AppColors.black,
  );

  static final TextStyle hint16 = style(
    fontSize: 16.sp,
    color: AppColors.hintColor,
  );

  static final TextStyle caption13 = style(
    fontSize: 13.sp,
    color: AppColors.black,
  );

  static final TextStyle caption13Gray = style(
    fontSize: 13.sp,
    color: AppColors.secondaryGray,
  );

  static final TextStyle caption13Primary = style(
    fontSize: 13.sp,
    color: AppColors.secondaryColor,
  );

  static const TextStyle button16Const = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle button14MediumConst = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle title14BoldConst = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle price18SecondaryConst = TextStyle(
    fontSize: 18,
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle title32BoldConst = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle title18PrimaryConst = TextStyle(
    fontSize: 18,
    color: AppColors.secondaryColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle body14BlackConst = TextStyle(
    fontSize: 14,
    color: AppColors.black,
  );

  static const TextStyle body14GreyConst = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryGray,
  );

  static const TextStyle body16GreyConst = TextStyle(
    fontSize: 16,
    color: AppColors.secondaryGray,
  );

  static const TextStyle caption13GreyConst = TextStyle(
    fontSize: 13,
    color: AppColors.secondaryGray,
  );
}
