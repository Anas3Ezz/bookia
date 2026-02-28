import 'package:bookia/feature/home/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: BookCarousel()));
  }
}

class BookCarousel extends StatefulWidget {
  const BookCarousel({super.key});

  @override
  BookCarouselState createState() => BookCarouselState();
}

class BookCarouselState extends State<BookCarousel> {
  final List<Color> slideColors = [
    Color(0xFFE58D7D), // Coral
    Colors.blueAccent,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GethomeSliderLoading) {
          return CircularProgressIndicator();
        } else if (state is GethomeSliderSucess) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CarouselSlider(
                items: List.generate(
                  state.sliders.length,
                  (index) => ClipRRect(
                    child: Image.network(
                      state.sliders[index].image ?? '',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                options: CarouselOptions(
                  height: 250,
                  viewportFraction: 0.9,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      // _currentIndex = index;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Text('EROOOR');
        }
      },
    );
  }
}
