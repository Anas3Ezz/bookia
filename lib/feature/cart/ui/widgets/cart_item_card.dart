import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/data/model/add_to_cart_model.dart';
import 'package:bookia/feature/cart/ui/widgets/quantity_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_theme.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CustomCachedImage(
              url: item.itemProductImage ?? '',
              width: 80.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemProductName ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.textPrimary,
                  ),
                ),
                Gap(4.h),
                Text(
                  '\$${item.itemProductPriceAfterDiscount?.toStringAsFixed(2) ?? item.itemProductPrice ?? ''}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(8.h),
                QuantityControls(item: item),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.cancel_outlined, color: context.appColors.hint),
            onPressed: () =>
                context.read<CartCubit>().removeFromCart(item.itemId ?? 0),
          ),
        ],
      ),
    );
  }
}
