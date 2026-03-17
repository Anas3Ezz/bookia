import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';

class SearchArgs {
  final CartCubit cartCubit;
  final WishlistCubit wishlistCubit;

  const SearchArgs({required this.cartCubit, required this.wishlistCubit});
}
