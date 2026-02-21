import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/feature/auth/ui/login_screen.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Assets.images.appLogo.image(),
              const SizedBox(height: 12),
              Text(
                'welcome.slogan'.tr(),
                style: AppTextsStyles.text18Regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2F2F2F),
                ),
              ),
              const Spacer(flex: 5),
              AppButton(
                text: 'welcome.login'.tr(),
                isFilled: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: 'welcome.register'.tr(),
                isFilled: false,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.isFilled,
  });
  final String text;
  final void Function()? onPressed;
  final bool isFilled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled ? const Color(0xFFBB9457) : Colors.white,
          foregroundColor: isFilled ? Colors.white : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: isFilled
                ? BorderSide.none
                : const BorderSide(color: Colors.black),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
