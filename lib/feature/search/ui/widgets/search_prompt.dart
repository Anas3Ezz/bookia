import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SearchPrompt extends StatelessWidget {
  const SearchPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            'Search for your book',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
