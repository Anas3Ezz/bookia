part of 'wishlist_cubit.dart';

@immutable
sealed class WishlistState {}

final class WishlistInitial extends WishlistState {}

// ─── Get Wishlist ─────────────────────────────
abstract class GetWishlistState extends WishlistState {}

final class GetWishlistLoading extends GetWishlistState {}

final class GetWishlistSuccess extends GetWishlistState {
  final List<WishlistItem> items;
  GetWishlistSuccess(this.items);
}

final class GetWishlistError extends GetWishlistState {
  final String message;
  GetWishlistError({this.message = 'Failed to load wishlist'});
}

// ─── Add To Wishlist ──────────────────────────
abstract class AddToWishlistState extends WishlistState {}

final class AddToWishlistLoading extends AddToWishlistState {}

final class AddToWishlistSuccess extends AddToWishlistState {
  final String message;
  AddToWishlistSuccess({this.message = 'Added to wishlist'});
}

final class AddToWishlistError extends AddToWishlistState {
  final String message;
  AddToWishlistError({this.message = 'Failed to add to wishlist'});
}

// ─── Remove From Wishlist ─────────────────────
abstract class RemoveFromWishlistState extends WishlistState {}

final class RemoveFromWishlistLoading extends RemoveFromWishlistState {}

final class RemoveFromWishlistSuccess extends RemoveFromWishlistState {}

final class RemoveFromWishlistError extends RemoveFromWishlistState {
  final String message;
  RemoveFromWishlistError({this.message = 'Failed to remove from wishlist'});
}
