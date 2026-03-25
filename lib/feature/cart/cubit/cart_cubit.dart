import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/add_to_cart_model.dart';
import '../data/repo/add_to_cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    emit(GetCartLoading());
    final (response, error) = await CartRepo.getCart();
    if (isClosed) return;

    response == null
        ? emit(GetCartError(message: error ?? 'Failed to load cart.'))
        : emit(GetCartSuccess(response.data ?? CartData()));
  }

  Future<void> _refreshCartSilently() async {
    final (response, _) = await CartRepo.getCart();
    if (isClosed) return;
    if (response != null) {
      emit(GetCartSuccess(response.data ?? CartData()));
    }
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoading());
    final (response, error) = await CartRepo.addToCart(productId);
    if (isClosed) return;

    if (response == null) {
      emit(AddToCartError(message: error ?? 'Failed to add to cart.'));
    } else {
      emit(AddToCartSuccess(message: response.message ?? 'Added to cart.'));
      await getCart();
    }
  }

  Future<void> removeFromCart(int itemId) async {
    emit(RemoveFromCartLoading());
    final (success, error) = await CartRepo.removeFromCart(itemId);
    if (isClosed) return;

    if (!success) {
      emit(RemoveFromCartError(message: error ?? 'Failed to remove item.'));
    } else {
      emit(RemoveFromCartSuccess());
      await getCart();
    }
  }

  Future<void> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    final (success, error) = await CartRepo.updateCartItem(
      itemId: itemId,
      quantity: quantity,
    );
    if (isClosed) return;

    if (!success) {
      emit(UpdateCartError(message: error ?? 'Failed to update quantity.'));
    } else {
      await _refreshCartSilently();
    }
  }
}
