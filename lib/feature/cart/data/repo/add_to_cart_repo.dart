import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';

class CartRepo {
  static Future<CartModel?> addToCart(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.addToCart,
        data: {'product_id': productId},
      );
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        return CartModel.fromJson(response?.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CartModel?> getCart() async {
    try {
      final response = await DioFactory.dio?.get(ApiConstants.showCart);
      if (response?.statusCode == 200) {
        return CartModel.fromJson(response?.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
