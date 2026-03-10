import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          context.pushNamedAndRemoveUntil(AppRoutes.login);
        },
        child: Text('Profile'),
      ),
    );
  }
}
