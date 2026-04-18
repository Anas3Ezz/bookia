import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuantityControls extends StatelessWidget {
  const QuantityControls({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final quantity = item.itemQuantity ?? 1;
    return Row(
      children: [
        _QuantityButton(
          icon: Icons.add,
          onTap: () => context.read<CartCubit>().updateCartItem(
            itemId: item.itemId ?? 0,
            quantity: quantity + 1,
          ),
        ),
        Gap(8.w),
        Text(
          quantity.toString().padLeft(2, '0'),
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
        Gap(8.w),
        _QuantityButton(
          icon: Icons.remove,
          onTap: () {
            if (quantity > 1) {
              context.read<CartCubit>().updateCartItem(
                itemId: item.itemId ?? 0,
                quantity: quantity - 1,
              );
            }
          },
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 20.sp),
    );
  }
}
