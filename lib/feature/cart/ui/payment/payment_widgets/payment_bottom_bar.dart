import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentBottomBar extends StatelessWidget {
  const PaymentBottomBar({super.key, required this.total, required this.onPay});

  final String total;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 28.h),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(top: BorderSide(color: context.appColors.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: context.appColors.subtitle,
                ),
              ),
              Text(
                '\$ $total',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textPrimary,
                ),
              ),
            ],
          ),
          Gap(12.h),
          AppButton(
            text: 'Pay Now',
            onPressed: onPay,
            isFilled: true,
            backgroundColor: AppColors.primaryColor,
            textColor: AppColors.white,
          ),
        ],
      ),
    );
  }
}
