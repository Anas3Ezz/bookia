import 'package:bookia/core/widgets/cashed_images.dart';
import 'package:bookia/feature/home/data/models/home_slider_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderCarousel extends StatelessWidget {
  const SliderCarousel({
    super.key,
    required this.sliders,
    required this.onPageChanged,
  });

  final List<SliderImages> sliders;
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
