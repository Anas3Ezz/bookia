import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookBottomActionBar extends StatelessWidget {
  const BookBottomActionBar({
    super.key,
    required this.productId,
    required this.price,
    this.priceAfterDiscount,
    this.discount,
  });

  final int productId;
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
            child: BlocConsumer<CartCubit, CartState>(
              listenWhen: (_, current) => current is AddToCartState,
              listener: (context, state) {
                if (state is AddToCartSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is AddToCartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              buildWhen: (_, current) => current is AddToCartState,
              builder: (context, state) {
                final isLoading = state is AddToCartLoading;
                return AppButton(
                  text: isLoading ? 'Adding...' : 'Add To Cart',
                  onPressed: isLoading
                      ? () {}
                      : () => context.read<CartCubit>().addToCart(productId),
                  isFilled: true,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
              },
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
            style: AppTextStyle.body14GreyConst.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Text(
            '\$${priceAfterDiscount!.toStringAsFixed(2)}',
            style: AppTextStyle.title32BoldConst,
          ),
        ],
      );
    }

    return Text('\$$price', style: AppTextStyle.title32BoldConst);
  }
}
