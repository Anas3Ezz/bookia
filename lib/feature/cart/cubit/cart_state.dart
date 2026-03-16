part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

// ─── Get Cart ────────────────────────────────
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

// ─── Add To Cart ─────────────────────────────
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

// ─── Remove From Cart ────────────────────────
abstract class RemoveFromCartState extends CartState {}

final class RemoveFromCartLoading extends RemoveFromCartState {}

final class RemoveFromCartSuccess extends RemoveFromCartState {}

final class RemoveFromCartError extends RemoveFromCartState {
  final String message;
  RemoveFromCartError({this.message = 'Failed to remove item'});
}

// ─── Update Cart Item ────────────────────────
abstract class UpdateCartState extends CartState {}

final class UpdateCartLoading extends UpdateCartState {}

final class UpdateCartSuccess extends UpdateCartState {}

final class UpdateCartError extends UpdateCartState {
  final String message;
  UpdateCartError({this.message = 'Failed to update quantity'});
}
