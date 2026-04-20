// core/widgets/auth_redirect_row.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AuthRedirectRow extends StatelessWidget {
  const AuthRedirectRow({
    super.key,
    required this.question,
    required this.actionText,
    required this.onTap,
  });

  final String question;
  final String actionText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question),
        InkWell(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
