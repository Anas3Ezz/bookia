import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.appColors.borderColor),
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
      ),
    );
  }
}
