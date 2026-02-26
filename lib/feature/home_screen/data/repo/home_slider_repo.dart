import 'package:bookia/core/helper/constants.dart';
import 'package:bookia/feature/home_screen/data/models/home_slider_model.dart';
import 'package:dio/dio.dart';

class HomeSliderRepo {
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
}
