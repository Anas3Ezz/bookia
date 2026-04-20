import 'package:easy_localization/easy_localization.dart';

class AppValidators {
  AppValidators._();
  // ─── Phone ────────────────────────────────────────────────────────────────

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_phone_required'.tr();
    }
    if (!RegExp(r'^\d{7,15}$').hasMatch(value.trim())) {
      return 'error_phone_invalid'.tr();
    }
    return null;
  }

  // ─── Email ────────────────────────────────────────────────────────────────

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_email_required'.tr();
    }
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(value.trim())) {
      return 'error_email_invalid'.tr();
    }
    return null;
  }

  // ─── Password ─────────────────────────────────────────────────────────────

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_password_required'.tr();
    }
    if (value.trim().length < 8) {
      return 'error_password_min_length'.tr();
    }
    // if (!RegExp(r'[A-Z]').hasMatch(value)) {
    //   return 'error_password_uppercase'.tr();
    // }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'error_password_number'.tr();
    }
    return null;
  }

  // ─── Confirm Password ─────────────────────────────────────────────────────

  /// Pass the original password value to compare against.
  /// Usage: validator: (val) => AppValidators.confirmPassword(val, _passwordController.text)
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.trim().isEmpty) {
      return 'error_confirm_password_required'.tr();
    }
    if (value.trim() != original.trim()) {
      return 'error_confirm_password_mismatch'.tr();
    }
    return null;
  }

  // ─── Name ─────────────────────────────────────────────────────────────────

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_name_required'.tr();
    }
    if (value.trim().length < 2) {
      return 'error_name_min_length'.tr();
    }
    if (!RegExp(r"^[a-zA-Z\u0600-\u06FF\s'-]+$").hasMatch(value.trim())) {
      return 'error_name_invalid'.tr();
    }
    return null;
  }

  // ─── Required (generic) ───────────────────────────────────────────────────

  /// Use for any field that just needs to be non-empty.
  /// Usage: validator: AppValidators.required
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_field_required'.tr();
    }
    return null;
  }

  // ─── OTP ──────────────────────────────────────────────────────────────────

  static String? otp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_otp_required'.tr();
    }
    if (!RegExp(r'^\d{4,6}$').hasMatch(value.trim())) {
      return 'error_otp_invalid'.tr();
    }
    return null;
  }

  // ─── URL ──────────────────────────────────────────────────────────────────

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'error_url_required'.tr();
    }
    if (!RegExp(
      r'^https?:\/\/[\w\-]+(\.[\w\-]+)+[/#?]?.*$',
    ).hasMatch(value.trim())) {
      return 'error_url_invalid'.tr();
    }
    return null;
  }
}
