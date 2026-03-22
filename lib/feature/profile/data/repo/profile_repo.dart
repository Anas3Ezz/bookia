import 'package:bookia/core/networking/api_constants.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/feature/profile/data/model/profile_model.dart';
import 'package:flutter/foundation.dart';

class ProfileRepo {
  static Future<ProfileModel?> getProfile() async {
    try {
      final response = await DioFactory.dio?.get(ApiConstants.profile);
      debugPrint('>>> getProfile status: ${response?.statusCode}');
      if (response?.statusCode == 200) {
        return ProfileModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      debugPrint('>>> getProfile error: $e');
      return null;
    }
  }
}
