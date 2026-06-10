import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bookia/core/theme/cubit/theme_cubit.dart';
import 'package:bookia/core/theme/cubit/theme_state.dart';
import 'package:bookia/core/theme/data/theme_local_data_source.dart';

class MockThemeLocalDataSource extends Mock implements ThemeLocalDataSource {}

void main() {
  late MockThemeLocalDataSource mockDs;

  setUp(() {
    mockDs = MockThemeLocalDataSource();
    when(() => mockDs.cacheTheme(any())).thenAnswer((_) async {});
  });

  group('ThemeCubit', () {
    test('initial state reflects the persisted theme (light)', () {
      when(() => mockDs.getTheme()).thenReturn('light');
      final cubit = ThemeCubit(mockDs);
      expect(cubit.state, const ThemeState(ThemeMode.light));
      cubit.close();
    });

    test('initial state reflects the persisted theme (dark)', () {
      when(() => mockDs.getTheme()).thenReturn('dark');
      final cubit = ThemeCubit(mockDs);
      expect(cubit.state, const ThemeState(ThemeMode.dark));
      cubit.close();
    });

    test('initial state reflects the persisted theme (system)', () {
      when(() => mockDs.getTheme()).thenReturn('system');
      final cubit = ThemeCubit(mockDs);
      expect(cubit.state, const ThemeState(ThemeMode.system));
      cubit.close();
    });

    test('unknown persisted value defaults to light theme', () {
      when(() => mockDs.getTheme()).thenReturn('unknown');
      final cubit = ThemeCubit(mockDs);
      expect(cubit.state, const ThemeState(ThemeMode.light));
      cubit.close();
    });

    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeState(dark) when changeTheme is called with dark',
      build: () {
        when(() => mockDs.getTheme()).thenReturn('light');
        return ThemeCubit(mockDs);
      },
      act: (cubit) => cubit.changeTheme(ThemeMode.dark),
      expect: () => [const ThemeState(ThemeMode.dark)],
      verify: (_) => verify(() => mockDs.cacheTheme('dark')).called(1),
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeState(light) when changeTheme is called with light',
      build: () {
        when(() => mockDs.getTheme()).thenReturn('dark');
        return ThemeCubit(mockDs);
      },
      act: (cubit) => cubit.changeTheme(ThemeMode.light),
      expect: () => [const ThemeState(ThemeMode.light)],
      verify: (_) => verify(() => mockDs.cacheTheme('light')).called(1),
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits ThemeState(system) when changeTheme is called with system',
      build: () {
        when(() => mockDs.getTheme()).thenReturn('light');
        return ThemeCubit(mockDs);
      },
      act: (cubit) => cubit.changeTheme(ThemeMode.system),
      expect: () => [const ThemeState(ThemeMode.system)],
      verify: (_) => verify(() => mockDs.cacheTheme('system')).called(1),
    );

    blocTest<ThemeCubit, ThemeState>(
      'emits two states when changeTheme is called twice',
      build: () {
        when(() => mockDs.getTheme()).thenReturn('light');
        return ThemeCubit(mockDs);
      },
      act: (cubit) async {
        await cubit.changeTheme(ThemeMode.dark);
        await cubit.changeTheme(ThemeMode.system);
      },
      expect: () => [
        const ThemeState(ThemeMode.dark),
        const ThemeState(ThemeMode.system),
      ],
    );
  });
}
