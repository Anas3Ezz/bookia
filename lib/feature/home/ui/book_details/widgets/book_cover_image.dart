import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:flutter/material.dart';

class BookCoverImage extends StatelessWidget {
  const BookCoverImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CustomCachedImage(
          url: imageUrl,
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
