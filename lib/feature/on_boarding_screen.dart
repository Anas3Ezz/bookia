import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/theme/app_texts_styles.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../core/routs/app_routs.dart';

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
              const Gap(12),
              Text(
                'Order Your Book Now!',
                style: AppTextStyle.style(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.textColor,
                ),
              ),
              const Spacer(flex: 5),
              AppButton(
                text: 'Login',
                isFilled: true,
                onPressed: () {
                  context.pushNamed(AppRoutes.login);
                },
              ),
              const Gap(15),
              AppButton(
                text: 'Register',
                isFilled: false,
                onPressed: () {
                  context.pushNamed(AppRoutes.register);
                },
              ),

              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}
