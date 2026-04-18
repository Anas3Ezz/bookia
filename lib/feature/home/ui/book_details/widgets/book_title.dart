import 'package:flutter/material.dart';

class BookTitles extends StatelessWidget {
  const BookTitles({super.key, required this.name, required this.category});

  final String name;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          category,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xffB9935E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
