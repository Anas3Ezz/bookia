import 'package:bloc/bloc.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:bookia/feature/wishlist/data/repo/wishlist_repo.dart';
import 'package:meta/meta.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  // Tracks wishlist product ids locally for instant icon toggle
  final Set<int> _wishlistIds = {};

  // Keeps last known items so UI doesn't flash during sync operations
  List<WishlistItem>? currentItems;

  bool isInWishlist(int productId) => _wishlistIds.contains(productId);

  Future<void> getWishlist() async {
    emit(GetWishlistLoading());
    final response = await WishlistRepo.getWishlist();
    if (isClosed) return;

    if (response == null) {
      emit(GetWishlistError());
    } else {
      final items = response.data?.items ?? [];
      _syncIds(items);
      currentItems = items;
      emit(GetWishlistSuccess(items));
    }
  }

  Future<void> addToWishlist(int productId) async {
    emit(AddToWishlistLoading());
    final success = await WishlistRepo.addToWishlist(productId);
    if (isClosed) return;

    if (!success) {
      emit(AddToWishlistError());
    } else {
      _wishlistIds.add(productId);
      emit(AddToWishlistSuccess());
      await _refreshWishlistSilently();
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(RemoveFromWishlistLoading());
    final success = await WishlistRepo.removeFromWishlist(productId);
    if (isClosed) return;

    if (!success) {
      emit(RemoveFromWishlistError());
    } else {
      _wishlistIds.remove(productId);
      emit(RemoveFromWishlistSuccess());
      await _refreshWishlistSilently();
    }
  }

  // Refreshes wishlist without showing loading skeleton
  Future<void> _refreshWishlistSilently() async {
    final response = await WishlistRepo.getWishlist();
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
