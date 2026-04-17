import 'package:bookia/bookia_app.dart';
import 'package:bookia/core/helper/bloc_observer.dart';
import 'package:bookia/core/helper/storge_services.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:bookia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // from firebase_options.dart
  );
  Bloc.observer = MyBlocObserver();
  await StorageService.init();
  await DioFactory.initDio();
  await ScreenUtil.ensureScreenSize();

  runApp(BookiaApp(token: StorageService.getToken()));

  //TODO : push notification & firestore
  // add a payment feature & dark mode &
  //  appColors and appTextStyles
}
