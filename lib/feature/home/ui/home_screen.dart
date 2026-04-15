import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:bookia/feature/home/ui/widgets/best_seller_grid.dart';
import 'package:bookia/feature/home/ui/widgets/best_seller_header.dart';
import 'package:bookia/feature/home/ui/widgets/custom_app_bar.dart';
import 'package:bookia/feature/home/ui/widgets/slider_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<HomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BookiaAppBar(),
      body: RefreshIndicator(
        color: const Color(0xFFB89B5E),
        onRefresh: () => _onRefresh(context),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SliderSection()),
            SliverToBoxAdapter(child: BestSellerHeader()),
            BestSellerGrid(),
            SliverToBoxAdapter(child: Gap(20)),
          ],
        ),
      ),
    );
  }
}
