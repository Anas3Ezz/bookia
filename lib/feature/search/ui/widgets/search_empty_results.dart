import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SearchEmptyResult extends StatelessWidget {
  const SearchEmptyResult({super.key, required this.query});

  final String query;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64.sp,
            color: Colors.grey.shade300,
          ),
          Gap(16.h),
          Text(
            'No results for "$query"',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
