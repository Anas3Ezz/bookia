import 'package:bookia/feature/home/ui/widgets/best_seller_grid_view.dart';
import 'package:bookia/feature/home/ui/widgets/book_carousel.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BookiaAppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: BookCarousel()),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Text(
                'Best Seller',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          BestSellerGridView(),
          const SliverToBoxAdapter(child: Gap(20)),
        ],
      ),
    );
  }
}

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
