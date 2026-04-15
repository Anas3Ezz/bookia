import 'package:bookia/core/routs/app_routers.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        return MaterialApp(
          theme: ThemeData(fontFamily: 'DMSerifDisplay'),
          darkTheme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          initialRoute: startRout(),
          onGenerateRoute: AppRouter.generateRoute,
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
