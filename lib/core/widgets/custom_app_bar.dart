import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      title: title != null
          ? Text(title!, style: AppTextStyle.title20Bold)
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
