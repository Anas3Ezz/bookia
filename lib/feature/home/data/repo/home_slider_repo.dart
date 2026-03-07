import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  static Future<SliderModel?> gethomeSliders() async {
    try {
      final response = await _dio.get(ApiConstants.homeSliderEndpoint);
      if (response.statusCode == 200) {
        return SliderModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<BooksModel?> getBestSellerBooks() async {
    try {
      final response = await _dio.get(ApiConstants.bestseller);
      if (response.statusCode == 200) {
        return BooksModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
