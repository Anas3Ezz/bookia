import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/home/data/models/book_details_arg.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/data/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistItemCard extends StatelessWidget {
  const WishlistItemCard({super.key, required this.item});

  final WishlistItem item;

  double? get _priceValue => double.tryParse(item.price ?? '');

  double? get _discountedPrice {
    if (_priceValue == null || item.discount == null || item.discount! <= 0) {
      return null;
    }
    return _priceValue! * (1 - item.discount! / 100);
  }

  Products get _productFromWishlistItem => Products(
    id: item.id,
    name: item.name,
    description: item.description,
    price: item.price,
    discount: item.discount,
    // wishlist item does not carry priceAfterDiscount from the API,
    // so we leave it null and let the details screen display the base price.
    priceAfterDiscount: null,
    stock: item.stock,
    bestSeller: item.bestSeller,
    image: item.image,
    category: item.category,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.booksDetails,
          arguments: BookDetailsArgs(
            book: _productFromWishlistItem,
            cartCubit: context.read<CartCubit>(),
            wishlistCubit: context.read<WishlistCubit>(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.surface,
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
                    style: AppTextStyle.style(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: context.appColors.textColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_discountedPrice != null) ...[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '\$${_discountedPrice!.toStringAsFixed(2)}',
                              style: AppTextStyle.price18SecondaryConst,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '\$${item.price ?? ''}',
                              style: AppTextStyle.body14Gray.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        Text(
                          '\$${item.price ?? ''}',
                          style: AppTextStyle.price18SecondaryConst,
                        ),
                      ],
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
      ),
    );
  }
}
