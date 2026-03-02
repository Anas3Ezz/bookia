import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();

  void pushAndRemoveUntil(String routeName) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // --- Widget Routing (Anonymous) ---
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement<T, dynamic>(MaterialPageRoute(builder: (_) => page));
  }

  // --- Popping & Utilities ---

  void popUntil(String routeName) {
    Navigator.of(this).popUntil(ModalRoute.withName(routeName));
  }

  bool get canPop => Navigator.of(this).canPop();
}

extension SizeExtension on num {
  // Vertical spacing
  Widget get height => SizedBox(height: toDouble());

  // Horizontal spacing
  Widget get width => SizedBox(width: toDouble());

  // Square spacing (Height & Width)
  Widget get sh => SizedBox(height: toDouble(), width: toDouble());
}
