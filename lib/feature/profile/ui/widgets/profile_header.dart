import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  final String name;
  final String email;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 5.h, 20.w, 0),
      child: Row(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: CustomCachedImage(
                url: imageUrl,
                fit: BoxFit.cover,
                width: 64.w,
                height: 64.w,
              ),
            ),
          ),
          Gap(16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: context.appColors.textColor,
                ),
              ),
              Gap(4.h),
              Text(
                email,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: context.appColors.textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
