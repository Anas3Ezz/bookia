import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';

class CongratesScreen extends StatelessWidget {
  const CongratesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void backToHome() {
      context.pushNamedAndRemoveUntil(AppRoutes.bottomNavBarScreen);
    }

    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset('assets/icons/paymentsucces.svg')),
              const SizedBox(height: 32),
              const Text(
                'SUCCESS!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order will be delivered soon.\nThank you for choosing our app!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 48),
              AppButton(
                text: 'Back To Home',
                onPressed: backToHome,
                isFilled: true,
                backgroundColor: const Color(0xFFBB9457),
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
