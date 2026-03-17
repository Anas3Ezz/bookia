import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:flutter/foundation.dart';

class WishlistRepo {
  static Future<WishlistModel?> getWishlist() async {
    try {
      final response = await DioFactory.dio?.get(ApiConstants.showWishlist);
      debugPrint('>>> getWishlist status: ${response?.statusCode}');
      if (response?.statusCode == 200) {
        return WishlistModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      debugPrint('>>> getWishlist error: $e');
      return null;
    }
  }

  static Future<bool> addToWishlist(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.addToWishlist,
        data: {'product_id': productId},
      );
      debugPrint('>>> addToWishlist status: ${response?.statusCode}');
      return response?.statusCode == 200 || response?.statusCode == 201;
    } catch (e) {
      debugPrint('>>> addToWishlist error: $e');
      return false;
    }
  }

  static Future<bool> removeFromWishlist(int productId) async {
    try {
      final response = await DioFactory.dio?.post(
        ApiConstants.removeFromWishlist,
        data: {'product_id': productId},
      );
      debugPrint('>>> removeFromWishlist status: ${response?.statusCode}');
      return response?.statusCode == 200 || response?.statusCode == 201;
    } catch (e) {
      debugPrint('>>> removeFromWishlist error: $e');
      return false;
    }
  }
}
