import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showLeading;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.showLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showLeading,
      backgroundColor: context.appColors.background,
      elevation: 0,
      centerTitle: true,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: context.appColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
