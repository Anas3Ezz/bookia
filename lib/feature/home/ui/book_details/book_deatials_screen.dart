import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/ui/book_details/widgets/book_cover_image.dart';
import 'package:bookia/feature/home/ui/book_details/widgets/book_description.dart';
import 'package:bookia/feature/home/ui/book_details/widgets/book_details_appbar.dart';
import 'package:bookia/feature/home/ui/book_details/widgets/book_title.dart';
import 'package:bookia/feature/home/ui/book_details/widgets/bottom_action_bar.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final Products book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BookDetailsAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              BookCoverImage(imageUrl: book.image ?? ''),
              const SizedBox(height: 25),
              BookTitles(name: book.name ?? '', category: book.category ?? ''),
              const SizedBox(height: 20),
              BookDescription(description: book.description ?? ''),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BookBottomActionBar(
        productId: book.id ?? 0,
        price: book.price ?? '0',
        priceAfterDiscount: book.priceAfterDiscount,
        discount: book.discount,
      ),
    );
  }
}
