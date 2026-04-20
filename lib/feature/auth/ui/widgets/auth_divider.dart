// core/widgets/auth_divider.dart
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: context.appColors.borderColor)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or'),
        ),
        Expanded(child: Divider(color: context.appColors.borderColor)),
      ],
    );
  }
}
