import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:bookia/feature/home/ui/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerGridView extends StatelessWidget {
  const BestSellerGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            current is BestSellerError ||
            current is BestSellerLoading ||
            current is BestSellerSucess,
        builder: (context, state) {
          if (state is BestSellerLoading) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is BestSellerSucess) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => BookCard(books: state.books[index]),
                childCount: state.books.length, // Your item count
              ),
            );
          } else {
            return Text('EROOR');
          }
        },
      ),
    );
  }
}
