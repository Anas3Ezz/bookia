import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BookCarousel extends StatefulWidget {
  const BookCarousel({super.key});

  @override
  BookCarouselState createState() => BookCarouselState();
}

class BookCarouselState extends State<BookCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GethomeSliderLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is GethomeSliderSucess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              CarouselSlider(
                items: state.sliders.map((slider) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        slider.image ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  state.sliders.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: _currentIndex == index ? 28 : 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? const Color(0xFFB89B5E)
                          : Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('Failed to load sliders')),
          );
        }
      },
    );
  }
}
