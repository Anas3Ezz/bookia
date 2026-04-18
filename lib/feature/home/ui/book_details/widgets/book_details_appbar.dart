import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_theme.dart';

class BookDetailsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookDetailsAppBar({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.background,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        BlocBuilder<WishlistCubit, WishlistState>(
          buildWhen: (_, current) =>
              current is AddToWishlistSuccess ||
              current is RemoveFromWishlistSuccess ||
              current is GetWishlistSuccess,
          builder: (context, state) {
            final isWishlisted = context.read<WishlistCubit>().isInWishlist(
              productId,
            );
            return IconButton(
              icon: Icon(
                isWishlisted
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_border_rounded,
                color: isWishlisted
                    ? const Color(0xFFB89B5E)
                    : AppColors.primaryColor,
              ),
              onPressed: () {
                if (isWishlisted) {
                  context.read<WishlistCubit>().removeFromWishlist(productId);
                } else {
                  context.read<WishlistCubit>().addToWishlist(productId);
                }
              },
            );
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
