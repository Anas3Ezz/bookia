import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:bookia/feature/home/ui/widgets/slider_carousel.dart';
import 'package:bookia/feature/home/ui/widgets/slider_indicator.dart';
import 'package:bookia/feature/home/ui/widgets/slider_skiliton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
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
                SliderCarousel(
                  sliders: state.sliders,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                ),
                const Gap(16),
                SliderIndicator(
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
          return const SliderSkeleton();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
