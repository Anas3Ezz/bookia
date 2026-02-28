import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/home_screen/cubit/home_cubit.dart';
import 'package:bookia/feature/home_screen/ui/home_screen.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getHomeSliders(),
      child: const HomeScreen(),
    ),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.black87,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.icons.bookmark),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.icons.shop),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(Assets.icons.profile),
            label: '',
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
