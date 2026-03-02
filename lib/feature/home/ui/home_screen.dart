import 'package:bookia/feature/home/ui/widgets/book_carousel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: Column(children: [BookCarousel()])),
      ),
    );
  }
}
