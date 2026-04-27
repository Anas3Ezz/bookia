import 'package:bookia/core/widgets/custom_app_bar.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_empty.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_error.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_grid.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_skeleton_grid.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_sync_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  bool _isSyncing(WishlistState state) =>
      state is RemoveFromWishlistLoading || state is AddToWishlistLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      appBar: CustomAppBar(title: 'Wishlist'),
      body: RefreshIndicator(
        onRefresh: () => context.read<WishlistCubit>().getWishlist(),
        child: BlocConsumer<WishlistCubit, WishlistState>(
          listener: (context, state) {
            if (state is RemoveFromWishlistError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is AddToWishlistError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                // Banner slides in during any sync operation
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) =>
                      SizeTransition(sizeFactor: animation, child: child),
                  child: _isSyncing(state)
                      ? const WishlistSyncBanner(key: ValueKey('banner'))
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
                Expanded(child: _buildBody(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, WishlistState state) {
    if (state is GetWishlistLoading || state is WishlistInitial) {
      return const WishlistSkeletonGrid();
    } else if (state is GetWishlistSuccess) {
      if (state.items.isEmpty) return const WishlistEmpty();
      return WishlistGrid(items: state.items);
    } else if (state is GetWishlistError) {
      return WishlistError(
        message: state.message,
        onRetry: () => context.read<WishlistCubit>().getWishlist(),
      );
    }
    // During sync states, keep showing the last successful grid
    // by reading current items from cubit — no flash, no rebuild
    final cubit = context.read<WishlistCubit>();
    final currentItems = cubit.currentItems;
    if (currentItems != null && currentItems.isNotEmpty) {
      return WishlistGrid(items: currentItems);
    }
    return const SizedBox.shrink();
  }
}
