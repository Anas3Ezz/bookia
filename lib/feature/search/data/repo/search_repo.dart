import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';

class SearchRepo {
  static Future<BooksModel?> searchBooks(String query) async {
    try {
      final response = await DioFactory.dio?.get(
        ApiConstants.productsSearch,
        queryParameters: {'name': query},
      );
      if (response?.statusCode == 200) {
        return BooksModel.fromJson(response?.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
