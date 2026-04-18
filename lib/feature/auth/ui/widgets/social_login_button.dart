import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const SocialLoginButton({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(color: context.appColors.borderColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 24),
            const Gap(8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
