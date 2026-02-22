import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/widgets/customr_app_button.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/routs/app_routs.dart';

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
                'slogan'.tr(),
                style: AppTextsStyles.text18Regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2F2F2F),
                ),
              ),
              const Spacer(flex: 5),
              AppButton(
                text: 'login'.tr(),
                isFilled: true,
                onPressed: () {
                  context.pushNamed(AppRoutes.login);
                },
              ),
              const SizedBox(height: 15),
              AppButton(
                text: 'register'.tr(),
                isFilled: false,
                onPressed: () {
                  context.pushNamed(AppRoutes.register);
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
