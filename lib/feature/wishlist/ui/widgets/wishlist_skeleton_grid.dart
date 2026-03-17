import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistSkeletonGrid extends StatelessWidget {
  const WishlistSkeletonGrid({super.key});

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.62,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Skeletonizer(
        enabled: true,
        child: GridView.builder(
          gridDelegate: _gridDelegate,
          itemCount: 6,
          itemBuilder: (_, _) => Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
