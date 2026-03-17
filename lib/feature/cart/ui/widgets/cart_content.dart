import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_checkout_bar.dart';
import 'package:bookia/feature/cart/ui/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartContent extends StatelessWidget {
  const CartContent({super.key, required this.cart});

  final CartData cart;

  @override
  Widget build(BuildContext context) {
    final items = cart.cartItems ?? [];
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: items.length,
            separatorBuilder: (_, _) => Gap(12.h),
            itemBuilder: (_, index) => CartItemCard(item: items[index]),
          ),
        ),
        CartCheckoutBar(total: cart.total ?? '0'),
      ],
    );
  }
}
