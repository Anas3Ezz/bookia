import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void backToLogin() {
      context.pushNamedAndRemoveUntil(AppRoutes.login);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset('assets/icons/paymentsucces.svg')),
              const SizedBox(height: 32),
              const Text(
                'Password Changed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                  color: AppColors.darkText,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your password has been changed\nsuccessfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryGray,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              AppButton(
                text: 'Back To Login',
                onPressed: backToLogin,
                isFilled: true,
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
