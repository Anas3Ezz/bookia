import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:flutter/foundation.dart';

class CartRepo {
  static Future<CartModel?> addToCart(int productId) async {
    try {
      debugPrint('>>> headers: ${DioFactory.dio?.options.headers}');
      final response = await DioFactory.dio?.post(
        ApiConstants.addToCart,
        data: {'product_id': productId},
      );
      debugPrint('>>> addToCart status: ${response?.statusCode}');
      debugPrint('>>> addToCart body: ${response?.data}');
      if (response?.statusCode == 201 || response?.statusCode == 200) {
        return CartModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      debugPrint('>>> addToCart error: $e');
      return null;
    }
  }

  static Future<CartModel?> getCart() async {
    try {
      debugPrint('>>> headers: ${DioFactory.dio?.options.headers}');
      final response = await DioFactory.dio?.get(ApiConstants.showCart);
      debugPrint('>>> getCart status: ${response?.statusCode}');
      debugPrint('>>> getCart body: ${response?.data}');
      if (response?.statusCode == 200) {
        return CartModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      debugPrint('>>> getCart error: $e');
      return null;
    }
  }

  static Future<bool> removeFromCart(int itemId) async {
    try {
      final response = await DioFactory.dio?.delete(
        '${ApiConstants.removeFromCart}/$itemId',
      );
      debugPrint('>>> removeFromCart status: ${response?.statusCode}');
      return response?.statusCode == 200 || response?.statusCode == 204;
    } catch (e) {
      debugPrint('>>> removeFromCart error: $e');
      return false;
    }
  }

  static Future<bool> updateCartItem({
    required int itemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactory.dio?.post(
        '${ApiConstants.updateCart}/$itemId',
        data: {'quantity': quantity},
      );
      debugPrint('>>> updateCartItem status: ${response?.statusCode}');
      return response?.statusCode == 200;
    } catch (e) {
      debugPrint('>>> updateCartItem error: $e');
      return false;
    }
  }
}
