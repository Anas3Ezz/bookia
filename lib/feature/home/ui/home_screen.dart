import 'package:bookia/feature/home/ui/widgets/best_seller_grid_view.dart';
import 'package:bookia/feature/home/ui/widgets/book_carousel.dart';
import 'package:bookia/feature/home/ui/widgets/custom_app_bar.dart';
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
