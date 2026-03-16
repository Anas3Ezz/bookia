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

    if (response == null) {
      emit(GetCartError());
    } else {
      emit(GetCartSuccess(response.data ?? CartData()));
    }
  }

  Future<void> addToCart(int productId) async {
    emit(AddToCartLoading());
    final response = await CartRepo.addToCart(productId);
    if (isClosed) return;

    if (response == null) {
      emit(AddToCartError());
    } else {
      emit(AddToCartSuccess(message: response.message ?? 'Added to cart'));
      // Refresh cart after adding
      await getCart();
    }
  }
}
