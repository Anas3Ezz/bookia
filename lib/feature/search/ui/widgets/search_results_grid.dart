import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({super.key, required this.books});

  final List<Products> books;

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.65,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: GridView.builder(
        gridDelegate: _gridDelegate,
        itemCount: books.length,
        itemBuilder: (context, index) => BookCard(books: books[index]),
      ),
    );
  }
}
