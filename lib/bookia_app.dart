import 'package:bookia/core/routs/app_routers.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/theme/cubit/theme_cubit.dart';
import 'package:bookia/core/theme/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main.dart';

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key, this.token});
  final String? token;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: state.themeMode,
              initialRoute: startRout(),
              onGenerateRoute: AppRouter.generateRoute,
            );
          },
        );
      },
    );
  }

  String startRout() {
    if (token == null) {
      return AppRoutes.onboarding;
    } else {
      return AppRoutes.bottomNavBarScreen;
    }
  }
}
