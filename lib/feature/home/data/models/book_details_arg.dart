import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';

class BookDetailsArgs {
  final Products book;
  final CartCubit cartCubit;
  final WishlistCubit wishlistCubit;

  const BookDetailsArgs({
    required this.book,
    required this.cartCubit,
    required this.wishlistCubit,
  });
}
