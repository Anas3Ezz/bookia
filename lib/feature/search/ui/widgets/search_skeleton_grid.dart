import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchSkeletonGrid extends StatelessWidget {
  const SearchSkeletonGrid({super.key});

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
      child: Skeletonizer(
        enabled: true,
        child: GridView.builder(
          gridDelegate: _gridDelegate,
          itemCount: 6,
          itemBuilder: (context, index) => BookCard(
            books: Products(name: 'Loading', price: '', image: ''),
          ),
        ),
      ),
    );
  }
}
