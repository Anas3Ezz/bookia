import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/theme_local_data_source.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeLocalDataSource localDataSource;

  ThemeCubit(this.localDataSource) : super(const ThemeState(ThemeMode.light));

  Future<void> loadTheme() async {
    final savedTheme = localDataSource.getTheme();

    if (savedTheme == 'dark') {
      emit(const ThemeState(ThemeMode.dark));
    } else if (savedTheme == 'system') {
      emit(const ThemeState(ThemeMode.system));
    } else {
      emit(const ThemeState(ThemeMode.light));
    }
  }

  Future<void> changeTheme(ThemeMode mode) async {
    emit(ThemeState(mode));

    String value;
    if (mode == ThemeMode.dark) {
      value = 'dark';
    } else if (mode == ThemeMode.system) {
      value = 'system';
    } else {
      value = 'light';
    }

    await localDataSource.cacheTheme(value);
  }
}
