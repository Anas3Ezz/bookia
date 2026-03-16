import 'package:bloc/bloc.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:bookia/feature/cart/data/repo/add_to_cart_repo.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    emit(GetCartLoading());
    final response = await CartRepo.getCart();
    if (isClosed) return;

    response == null
        ? emit(GetCartError())
        : emit(GetCartSuccess(response.data ?? CartData()));
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoading());
    final response = await CartRepo.addToCart(productId);
    if (isClosed) return;

    if (response == null) {
      emit(AddToCartError());
    } else {
      emit(AddToCartSuccess(message: response.message ?? 'Added to cart'));
      await getCart();
    }
  }

  Future<void> removeFromCart(int itemId) async {
    emit(RemoveFromCartLoading());
    final success = await CartRepo.removeFromCart(itemId);
    if (isClosed) return;

    if (!success) {
      emit(RemoveFromCartError());
    } else {
      emit(RemoveFromCartSuccess());
      await getCart();
    }
  }

  Future<void> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    emit(UpdateCartLoading());
    final success = await CartRepo.updateCartItem(
      itemId: itemId,
      quantity: quantity,
    );
    if (isClosed) return;

    if (!success) {
      emit(UpdateCartError());
    } else {
      emit(UpdateCartSuccess());
      await getCart();
    }
  }
}
