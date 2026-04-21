import 'package:bookia/bookia_app.dart';
import 'package:bookia/core/helper/bloc_observer.dart';
import 'package:bookia/core/helper/storage_services.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/core/theme/cubit/theme_cubit.dart';
import 'package:bookia/core/theme/data/theme_local_data_source.dart';
import 'package:bookia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await StorageService.init();
  await DioFactory.initDio();
  await ScreenUtil.ensureScreenSize();
  final themeLocalDataSource = ThemeLocalDataSource();
  await themeLocalDataSource.init();

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(themeLocalDataSource),
      child: BookiaApp(token: StorageService.getToken()),
    ),
  );

  //TODO:
  // Pull to refresh — you mentioned this was remaining on home, cart, wishlist
  // Token expiry — when the token expires, the app should logout the user and redirect to login automatically
  // Form validation on Place Order — governorate dropdown needs proper validation wiring
  // App icon and splash screen — need to be finalized and tested on different screen sizes
  // Remove all debug logs and print statements — before release
}
