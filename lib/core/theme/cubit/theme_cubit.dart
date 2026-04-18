import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/theme_local_data_source.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeLocalDataSource localDataSource;

  ThemeCubit(this.localDataSource)
    : super(ThemeState(_parseTheme(localDataSource.getTheme())));

  void loadTheme() {
    final savedTheme = localDataSource.getTheme();
    emit(ThemeState(_parseTheme(savedTheme)));
  }

  Future<void> changeTheme(ThemeMode mode) async {
    emit(ThemeState(mode));
    await localDataSource.cacheTheme(_serializeTheme(mode));
  }

  static ThemeMode _parseTheme(String value) {
    return switch (value) {
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light,
    };
  }

  static String _serializeTheme(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
      ThemeMode.light => 'light',
    };
  }
}
