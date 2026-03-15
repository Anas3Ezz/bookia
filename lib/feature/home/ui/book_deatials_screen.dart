import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.book});

  final Products book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _BookCoverImage(imageUrl: book.image ?? ''),
              const SizedBox(height: 25),
              _BookTitles(name: book.name ?? '', category: book.category ?? ''),
              const SizedBox(height: 20),
              _BookDescription(description: book.description ?? ''),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomActionBar(
        price: book.price ?? '0',
        priceAfterDiscount: book.priceAfterDiscount,
        discount: book.discount,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _CustomAppBar
// ─────────────────────────────────────────────

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.bookmark_border_rounded, color: Colors.black),
          onPressed: () {},
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// ─────────────────────────────────────────────
// _BookCoverImage
// ─────────────────────────────────────────────

class _BookCoverImage extends StatelessWidget {
  const _BookCoverImage({required this.imageUrl});

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

// ─────────────────────────────────────────────
// _BookTitles
// ─────────────────────────────────────────────

class _BookTitles extends StatelessWidget {
  const _BookTitles({required this.name, required this.category});

  final String name;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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

// ─────────────────────────────────────────────
// _BookDescription
// ─────────────────────────────────────────────

class _BookDescription extends StatelessWidget {
  const _BookDescription({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    // Strip HTML tags from description (API returns <p>...</p>)
    final cleanDescription = description.replaceAll(RegExp(r'<[^>]*>'), '');

    return Text(
      cleanDescription,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 14,
        height: 1.6,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _BottomActionBar
// ─────────────────────────────────────────────

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.price,
    this.priceAfterDiscount,
    this.discount,
  });

  final String price;
  final double? priceAfterDiscount;
  final int? discount;

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount =
        discount != null && discount! > 0 && priceAfterDiscount != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasDiscount) ...[
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '\$${priceAfterDiscount!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ] else
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: AppButton(
              text: 'Add To Cart',
              onPressed: () {},
              isFilled: true,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
