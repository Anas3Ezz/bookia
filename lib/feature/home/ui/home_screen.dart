import 'package:bookia/feature/home/ui/widgets/best_seller_grid.dart';
import 'package:bookia/feature/home/ui/widgets/best_seller_header.dart';
import 'package:bookia/feature/home/ui/widgets/custom_app_bar.dart';
import 'package:bookia/feature/home/ui/widgets/slider_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BookiaAppBar(),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SliderSection()),
          SliverToBoxAdapter(child: BestSellerHeader()),
          BestSellerGrid(),
          SliverToBoxAdapter(child: Gap(20)),
        ],
      ),
    );
  }
}
