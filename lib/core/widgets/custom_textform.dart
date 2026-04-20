import 'package:bookia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final void Function(bool hasFocus)? onFocusChanged;

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
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onFocusChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _hasUnfocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && !_hasUnfocused) {
        setState(() => _hasUnfocused = true);
      }
      widget.onFocusChanged?.call(_focusNode.hasFocus);
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
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      onChanged: widget.onChanged,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: context.appColors.hint),
        fillColor: context.appColors.fillColor,
        filled: true,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.appColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.appColors.borderColor),
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
