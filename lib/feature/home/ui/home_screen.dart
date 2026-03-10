import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:bookia/feature/home/data/models/books_model.dart';
import 'package:bookia/feature/home/ui/widgets/book_card.dart';
import 'package:bookia/feature/home/ui/widgets/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

// ─────────────────────────────────────────────
// HomeScreen
// ─────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BookiaAppBar(),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: _SliderSection()),
          const SliverToBoxAdapter(child: _BestSellerHeader()),
          const _BestSellerGrid(),
          const SliverToBoxAdapter(child: Gap(20)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _SliderSection
// ─────────────────────────────────────────────

class _SliderSection extends StatefulWidget {
  const _SliderSection();

  @override
  State<_SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<_SliderSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is GetHomeSliderState,
      builder: (context, state) {
        if (state is GetHomeSliderSuccess) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SliderCarousel(
                  sliders: state.sliders,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                ),
                const Gap(16),
                _SliderIndicator(
                  count: state.sliders.length,
                  currentIndex: _currentIndex,
                ),
              ],
            ),
          );
        } else if (state is GetHomeSliderError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => context.read<HomeCubit>().getHomeSliders(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is GetHomeSliderLoading || state is HomeInitial) {
          return const _SliderSkeleton();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

// ─────────────────────────────────────────────
// _SliderCarousel
// ─────────────────────────────────────────────

class _SliderCarousel extends StatelessWidget {
  const _SliderCarousel({required this.sliders, required this.onPageChanged});

  final List<dynamic> sliders;
  final void Function(int index) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: sliders.map((slider) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomCachedImage(
              url: slider.image ?? '',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200.h,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: false,
        onPageChanged: (index, _) => onPageChanged(index),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _SliderIndicator
// ─────────────────────────────────────────────

class _SliderIndicator extends StatelessWidget {
  const _SliderIndicator({required this.count, required this.currentIndex});

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == index ? 28 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? const Color(0xFFB89B5E)
                : Colors.grey.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _SliderSkeleton
// ─────────────────────────────────────────────

class _SliderSkeleton extends StatelessWidget {
  const _SliderSkeleton();
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: 200.h,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        color: Colors.grey,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _BestSellerHeader
// ─────────────────────────────────────────────

class _BestSellerHeader extends StatelessWidget {
  const _BestSellerHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
      child: Text(
        'Best Seller',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _BestSellerGrid
// ─────────────────────────────────────────────

class _BestSellerGrid extends StatelessWidget {
  const _BestSellerGrid();

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.65,
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
  );

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => current is BestSellerState,
        builder: (context, state) {
          if (state is BestSellerLoading) {
            return _BestSellerSkeletonGrid(gridDelegate: _gridDelegate);
          } else if (state is BestSellerSuccess) {
            return SliverGrid(
              gridDelegate: _gridDelegate,
              delegate: SliverChildBuilderDelegate(
                (context, index) => BookCard(books: state.books[index]),
                childCount: state.books.length,
              ),
            );
          } else if (state is BestSellerError) {
            return SliverToBoxAdapter(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () =>
                          context.read<HomeCubit>().getBestSellerBooks(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────
// _BestSellerSkeletonGrid
// ─────────────────────────────────────────────

class _BestSellerSkeletonGrid extends StatelessWidget {
  const _BestSellerSkeletonGrid({required this.gridDelegate});

  final SliverGridDelegateWithFixedCrossAxisCount gridDelegate;

  @override
  Widget build(BuildContext context) {
    return SliverSkeletonizer(
      enabled: true,
      child: SliverGrid(
        gridDelegate: gridDelegate,
        delegate: SliverChildBuilderDelegate(
          (context, index) => BookCard(
            books: Products(name: 'test', price: '', image: ''),
          ),
          childCount: 5,
        ),
      ),
    );
  }
}
