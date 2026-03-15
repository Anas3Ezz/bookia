import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:flutter/material.dart';

class BookBottomActionBar extends StatelessWidget {
  const BookBottomActionBar({
    super.key,
    required this.price,
    this.priceAfterDiscount,
    this.discount,
  });

  final String price;
  final double? priceAfterDiscount;
  final int? discount;

  bool get _hasDiscount =>
      discount != null && discount! > 0 && priceAfterDiscount != null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _PriceSection(
            price: price,
            priceAfterDiscount: priceAfterDiscount,
            hasDiscount: _hasDiscount,
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

// ─────────────────────────────────────────────
// _PriceSection
// ─────────────────────────────────────────────

class _PriceSection extends StatelessWidget {
  const _PriceSection({
    required this.price,
    required this.hasDiscount,
    this.priceAfterDiscount,
  });

  final String price;
  final double? priceAfterDiscount;
  final bool hasDiscount;

  @override
  Widget build(BuildContext context) {
    if (hasDiscount) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      );
    }

    return Text(
      '\$$price',
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
