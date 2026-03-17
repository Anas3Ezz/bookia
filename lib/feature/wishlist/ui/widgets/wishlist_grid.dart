import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:bookia/feature/wishlist/ui/widgets/wishlist_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistGrid extends StatelessWidget {
  const WishlistGrid({super.key, required this.items});

  final List<WishlistItem> items;

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.62,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      gridDelegate: _gridDelegate,
      itemCount: items.length,
      itemBuilder: (_, index) => WishlistItemCard(item: items[index]),
    );
  }
}
