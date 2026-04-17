import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({super.key, required this.item});

  final WishlistItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CustomCachedImage(
                url: item.image ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price ?? ''}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context
                          .read<WishlistCubit>()
                          .removeFromWishlist(item.id ?? 0),
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
