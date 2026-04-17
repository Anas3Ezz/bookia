import 'package:bookia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.suffixIcon,
    required this.controller,
    this.validator,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  // Only start validating after the user has left the field at least once
  bool _hasUnfocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && !_hasUnfocused) {
        setState(() => _hasUnfocused = true);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  static const _borderRadius = BorderRadius.all(Radius.circular(8));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Only auto-validate after the user has left the field once
      autovalidateMode: _hasUnfocused
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.hintColor),
        fillColor: AppColors.fillColor,
        filled: true,
        suffixIcon: widget.suffixIcon,
        border: const OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
