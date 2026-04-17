import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestSellerSkeletonGrid extends StatelessWidget {
  const BestSellerSkeletonGrid({super.key, required this.gridDelegate});

  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  @override
  Widget build(BuildContext context) {
    return SliverSkeletonizer(
      enabled: true,
      child: SliverGrid(
        gridDelegate: gridDelegate,
        delegate: SliverChildBuilderDelegate(
          (context, index) => BookCard(
            books: Products(name: 'test', price: '', image: ''),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}
