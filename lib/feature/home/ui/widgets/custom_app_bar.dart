import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/search/data/model/search_args.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookiaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BookiaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Image.asset(Assets.images.appLogo.path, height: 35),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
