import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookiaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookiaAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Image.asset(Assets.images.appLogo.path, height: 28.h),
            SizedBox(width: 8.w),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(size: 35, Icons.search, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
