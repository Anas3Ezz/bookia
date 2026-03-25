import 'package:bookia/core/helper/error_handler.dart';
import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';

class HomeRepo {
  static Future<(SliderModel?, String?)> getHomeSliders() async {
    try {
      final response = await DioFactory.dio?.get(
        ApiConstants.homeSliderEndpoint,
      );
      if (response?.statusCode == 200) {
        return (SliderModel.fromJson(response?.data), null);
      }
      return (null, 'Failed to load sliders.');
    } catch (e) {
      return (null, ErrorHandler.handle(e));
    }
  }

  static Future<(BooksModel?, String?)> getBestSellerBooks() async {
    try {
      final response = await DioFactory.dio?.get(ApiConstants.bestseller);
      if (response?.statusCode == 200) {
        return (BooksModel.fromJson(response?.data), null);
      }
      return (null, 'Failed to load best sellers.');
    } catch (e) {
      return (null, ErrorHandler.handle(e));
    }
  }
}
