import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.books});

  final Products books;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.booksDetails,
        arguments: books,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomCachedImage(
                height: 200,
                url: books.image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            books.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${books.price ?? ''}',
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFB89B5E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
