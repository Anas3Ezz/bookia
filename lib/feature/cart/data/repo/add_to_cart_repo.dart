import 'package:bookia/core/helper/error_handler.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:flutter/foundation.dart';

class CartRepo {
  static Future<(CartModel?, String?)> addToCart(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.addToCart,
        data: {'product_id': productId},
      );
      debugPrint('>>> addToCart status: ${response?.statusCode}');
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        return (CartModel.fromJson(response?.data), null);
      }
      return (null, 'Failed to add to cart.');
    } catch (e) {
      return (null, ErrorHandler.handle(e));
    }
  }

  static Future<(CartModel?, String?)> getCart() async {
    try {
      final response = await DioFactory.dio?.get(ApiConstants.showCart);
      debugPrint('>>> getCart status: ${response?.statusCode}');
      if (response?.statusCode == 200) {
        return (CartModel.fromJson(response?.data), null);
      }
      return (null, 'Failed to load cart.');
    } catch (e) {
      return (null, ErrorHandler.handle(e));
    }
  }

  static Future<(bool, String?)> removeFromCart(int itemId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.removeFromCart,
        data: {'cart_item_id': itemId},
      );
      debugPrint('>>> removeFromCart status: ${response?.statusCode}');
      if (response?.statusCode == 200) return (true, null);
      return (false, 'Failed to remove item.');
    } catch (e) {
      return (false, ErrorHandler.handle(e));
    }
  }

  static Future<(bool, String?)> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.updateCart,
        data: {'cart_item_id': itemId, 'quantity': quantity},
      );
      debugPrint('>>> updateCartItem status: ${response?.statusCode}');
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        return (true, null);
      }
      return (false, 'Failed to update quantity.');
    } catch (e) {
      return (false, ErrorHandler.handle(e));
    }
  }
}
