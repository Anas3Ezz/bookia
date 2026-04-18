import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/cart/cubit/cart_cubit.dart';
import 'package:bookia/feature/home/data/models/book_details_arg.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/wishlist/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.books});

  final Products books;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.booksDetails,
        arguments: BookDetailsArgs(
          book: books,
          cartCubit: context.read<CartCubit>(),
          wishlistCubit: context.read<WishlistCubit>(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: CustomCachedImage(
                  url: books.image ?? '',
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
                    books.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.appColors.textPrimary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$${books.price ?? ''}',
                    style: AppTextStyle.price18SecondaryConst,
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
