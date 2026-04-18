import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:bookia/feature/home/ui/widgets/best_seller_grid.dart';
import 'package:bookia/feature/home/ui/widgets/best_seller_header.dart';
import 'package:bookia/feature/home/ui/widgets/slider_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/routs/app_routs.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../search/data/model/search_args.dart';
import '../../wishlist/cubit/wishlist_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<HomeCubit>().getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: CustomAppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 30),
            onPressed: () => Navigator.pushNamed(
              context,
              AppRoutes.searchScreen,
              arguments: SearchArgs(
                cartCubit: context.read<CartCubit>(),
                wishlistCubit: context.read<WishlistCubit>(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: context.appColors.secondaryColor,
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
