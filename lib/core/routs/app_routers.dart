import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/feature/auth/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/ui/login_screen.dart';
import 'package:bookia/feature/auth/ui/on_boarding_screen.dart';
import 'package:bookia/feature/auth/ui/register_screen.dart';
import 'package:bookia/feature/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:bookia/feature/home/ui/book_details/book_deatials_screen.dart';
import 'package:bookia/feature/search/cubit/search_cubit.dart';
import 'package:bookia/feature/search/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (_) => AuthCubit(), child: LoginScreen()),
        );

      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(create: (_) => AuthCubit(), child: RegisterScreen()),
        );

      case AppRoutes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SearchCubit(),
            child: const SearchScreen(),
          ),
        );

      case AppRoutes.bottomNavBarScreen:
        return MaterialPageRoute(builder: (_) => const BottomNavBarScreen());

      case AppRoutes.booksDetails:
        final args = settings.arguments as BookDetailsArgs;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            // Reuse the same CartCubit — no new instance created
            value: args.cartCubit,
            child: BookDetailsScreen(book: args.book),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
