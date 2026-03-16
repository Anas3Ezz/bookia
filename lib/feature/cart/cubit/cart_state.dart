part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// ─── Get Cart States ─────────────────────────
abstract class GetCartState extends CartState {}

final class GetCartLoading extends GetCartState {}

final class GetCartSuccess extends GetCartState {
  final CartData cart;
  GetCartSuccess(this.cart);
}

final class GetCartError extends GetCartState {
  final String message;
  GetCartError({this.message = 'Failed to load cart'});
}

// ─── Add To Cart States ──────────────────────
abstract class AddToCartState extends CartState {}

final class AddToCartLoading extends AddToCartState {}

final class AddToCartSuccess extends AddToCartState {
  final String message;
  AddToCartSuccess({this.message = 'Added to cart successfully'});
}

final class AddToCartError extends AddToCartState {
  final String message;
  AddToCartError({this.message = 'Failed to add to cart'});
}
