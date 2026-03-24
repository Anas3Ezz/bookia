import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFilled = true,
    this.backgroundColor,
    this.textColor,
  });

  final String text;
  final void Function()? onPressed;
  final bool isFilled;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final Color effectiveBgColor =
        backgroundColor ?? (isFilled ? const Color(0xFFBB9457) : Colors.white);

    final Color effectiveTextColor =
        textColor ?? (isFilled ? Colors.white : Colors.black);

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBgColor,
          foregroundColor: effectiveTextColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isFilled
                ? BorderSide.none
                : BorderSide(
                    color: effectiveTextColor,
                  ), // Border matches text color
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
