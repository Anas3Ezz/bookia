import 'package:bloc/bloc.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:meta/meta.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  final Set<int> _wishlistIds = {};
  List<WishlistItem>? currentItems;

  bool isInWishlist(int productId) => _wishlistIds.contains(productId);

  Future<void> getWishlist() async {
    emit(GetWishlistLoading());
    final (response, error) = await WishlistRepo.getWishlist();
    if (isClosed) return;

    if (response == null) {
      emit(GetWishlistError(message: error ?? 'Failed to load wishlist.'));
    } else {
      final items = response.data?.items ?? [];
      _syncIds(items);
      currentItems = items;
      emit(GetWishlistSuccess(items));
    }
  }

  Future<void> addToWishlist(int productId) async {
    emit(AddToWishlistLoading());
    final (success, error) = await WishlistRepo.addToWishlist(productId);
    if (isClosed) return;

    if (!success) {
      emit(AddToWishlistError(message: error ?? 'Failed to add to wishlist.'));
    } else {
      _wishlistIds.add(productId);
      emit(AddToWishlistSuccess());
      await _refreshWishlistSilently();
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(RemoveFromWishlistLoading());
    final (success, error) = await WishlistRepo.removeFromWishlist(productId);
    if (isClosed) return;

    if (!success) {
      emit(
        RemoveFromWishlistError(
          message: error ?? 'Failed to remove from wishlist.',
        ),
      );
    } else {
      _wishlistIds.remove(productId);
      emit(RemoveFromWishlistSuccess());
      await _refreshWishlistSilently();
    }
  }

  Future<void> _refreshWishlistSilently() async {
    final (response, _) = await WishlistRepo.getWishlist();
    if (isClosed) return;
    if (response != null) {
      final items = response.data?.items ?? [];
      _syncIds(items);
      currentItems = items;
      emit(GetWishlistSuccess(items));
    }
  }

  void _syncIds(List<WishlistItem> items) {
    _wishlistIds
      ..clear()
      ..addAll(items.map((e) => e.id ?? 0));
  }
}
