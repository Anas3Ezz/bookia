import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class BestSellerHeader extends StatelessWidget {
  const BestSellerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
      child: Text(
        'Best Seller',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: context.appColors.textColor,
        ),
      ),
    );
  }
}
