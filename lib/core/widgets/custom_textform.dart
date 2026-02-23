import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextEditingController controller;
  // --- ADDED PROPERTIES ---
  final String? Function(String?)? validator; // For form validation
  final TextInputType? keyboardType; // To show the '@' or numeric keyboard
  final Iterable<String>? autofillHints; // Helps password managers
  final TextInputAction? textInputAction; // "Next" or "Done" button on keyboard

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
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator, // Connects logic to the Form
      keyboardType: keyboardType, // UX Improvement
      autofillHints: autofillHints, // UX & Security Improvement
      textInputAction: textInputAction, // Flow Improvement
      obscureText: isPassword,
      cursorColor: const Color(0xFFBB9457),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFBB9457), width: 1.5),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF8391A1)),
        fillColor: const Color(0xFFF7F8F9),
        filled: true,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
        ),
      ),
    );
  }
}
