import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_theme.dart';

class CartCheckoutBar extends StatelessWidget {
  const CartCheckoutBar({super.key, required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 28.h),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: TextStyle(fontSize: 16.sp)),
              Text(
                '\$ $total',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textColor,
                ),
              ),
            ],
          ),
          Gap(12.h),
          AppButton(
            text: 'Check Out',
            isFilled: true,
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.placeOrder,
                arguments: total, // already a String from CartData
              );
            },
          ),
        ],
      ),
    );
  }
}
