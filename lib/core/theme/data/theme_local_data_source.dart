import 'package:hive_flutter/hive_flutter.dart';

class ThemeLocalDataSource {
  static const _boxName = 'theme_box';
  static const _key = 'theme_mode';

  Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }

  Future<void> cacheTheme(String theme) async {
    final box = Hive.box<String>(_boxName);
    await box.put(_key, theme);
  }

  String getTheme() {
    final box = Hive.box<String>(_boxName);
    return box.get(_key, defaultValue: 'light')!;
  }
}
