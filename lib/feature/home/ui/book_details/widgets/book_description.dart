import 'package:flutter/material.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    // Strip HTML tags coming from the API e.g. <p>...</p>
    final cleanDescription = description.replaceAll(RegExp(r'<[^>]*>'), '');

    return Text(
      cleanDescription,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        height: 1.6,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
