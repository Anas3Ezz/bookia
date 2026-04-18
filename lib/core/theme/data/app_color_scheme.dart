import 'package:bookia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppColorScheme extends ThemeExtension<AppColorScheme> {
  final Color background;
  final Color surface;
  final Color fillColor;
  final Color borderColor;
  final Color textPrimary;
  final Color textColor;
  final Color subtitle;
  final Color hint;
  final Color gray;
  final Color secondaryGray;
  final Color secondaryColor;

  const AppColorScheme({
    required this.background,
    required this.surface,
    required this.fillColor,
    required this.borderColor,
    required this.textPrimary,
    required this.textColor,
    required this.subtitle,
    required this.hint,
    required this.gray,
    required this.secondaryGray,
    required this.secondaryColor,
  });

  // ── Presets ──────────────────────────────────────────────────

  static const light = AppColorScheme(
    background: AppColors.lightBackground,
    surface: AppColors.white,
    fillColor: AppColors.lightFillColor,
    borderColor: AppColors.lightBorderColor,
    textPrimary: AppColors.lightTextPrimary,
    textColor: AppColors.lightTextColor,
    subtitle: AppColors.lightSubtitle,
    hint: AppColors.lightHint,
    gray: AppColors.lightGray,
    secondaryGray: AppColors.lightSecGray,
    secondaryColor: AppColors.secondaryColor,
  );

  static const dark = AppColorScheme(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    fillColor: AppColors.darkFillColor,
    borderColor: AppColors.darkBorderColor,
    textPrimary: AppColors.darkTextPrimary,
    textColor: AppColors.darkTextColor,
    subtitle: AppColors.darkSubtitle,
    hint: AppColors.darkHint,
    gray: AppColors.darkGray,
    secondaryGray: AppColors.darkSecGray,
    secondaryColor: AppColors.secondaryColor,
  );

  // ── Required overrides ───────────────────────────────────────

  @override
  AppColorScheme copyWith({
    Color? background,
    Color? surface,
    Color? fillColor,
    Color? borderColor,
    Color? textPrimary,
    Color? textColor,
    Color? subtitle,
    Color? hint,
    Color? gray,
    Color? secondaryGray,
    Color? secondaryColor,
  }) {
    return AppColorScheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textColor: textColor ?? this.textColor,
      subtitle: subtitle ?? this.subtitle,
      hint: hint ?? this.hint,
      gray: gray ?? this.gray,
      secondaryGray: secondaryGray ?? this.secondaryGray,
      secondaryColor: secondaryColor ?? this.secondaryColor,
    );
  }

  @override
  AppColorScheme lerp(AppColorScheme? other, double t) {
    if (other == null) return this;
    return AppColorScheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      subtitle: Color.lerp(subtitle, other.subtitle, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      gray: Color.lerp(gray, other.gray, t)!,
      secondaryGray: Color.lerp(secondaryGray, other.secondaryGray, t)!,
      secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
    );
  }
}
