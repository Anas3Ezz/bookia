import 'package:bookia/core/routs/app_routers.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookiaApp extends StatelessWidget {
  final String? token;
  const BookiaApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(fontFamily: 'DMSerifDisplay'),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
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
      return AppRoutes.home;
    }
  }
}
