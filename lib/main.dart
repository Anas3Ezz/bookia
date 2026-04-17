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
  await Hive.initFlutter(); // FIRST
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await StorageService.init();
  await DioFactory.initDio();
  await ScreenUtil.ensureScreenSize();
  final themeLocalDataSource = ThemeLocalDataSource();
  await themeLocalDataSource.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(themeLocalDataSource)..loadTheme(),
        ),
      ],
      child: BookiaApp(token: StorageService.getToken()),
    ),
  );
  //TODO: finish the Darkmode for the app with good ui
  //TODO: add text style class for the app
  //TODO: add the payment feature to the app
}
