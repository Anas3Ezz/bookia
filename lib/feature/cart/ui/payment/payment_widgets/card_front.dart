import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardFront extends StatelessWidget {
  const CardFront({
    super.key,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiry,
  });

  final String cardNumber;
  final String cardHolder;
  final String expiry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2C1810), Color(0xFF4A2E1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BOOKIA',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              Container(
                width: 40.w,
                height: 28.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            cardNumber.isEmpty ? '••••  ••••  ••••  ••••' : cardNumber,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CARD HOLDER',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 9.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    cardHolder.isEmpty
                        ? '••••••••••'
                        : cardHolder.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPIRES',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 9.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    expiry.isEmpty ? '••/••' : expiry,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
