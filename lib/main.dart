import 'package:bookia/bookia_app.dart';
import 'package:bookia/core/helper/bloc_observer.dart';
import 'package:bookia/core/helper/storge_services.dart';
import 'package:bookia/core/networking/dio_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await StorageService.init();
  await DioFactory.initDio();
  await ScreenUtil.ensureScreenSize();

  runApp(BookiaApp(token: StorageService.getToken()));
  //TODO : add firebase and push notification &
  // finish edit profile screen &
  // add a payment feature & dark mode &
  //  appColors and appTextStyles
}
