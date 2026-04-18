import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/helper/validators.dart';
import '../../../../core/theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSendCode() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      try {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          context.pushNamed(AppRoutes.otpVerfication);
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(16.h),
              const CustomBackButton(),
              Gap(32.h),
              Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              Gap(12.h),
              Text(
                "Don't worry! It occurs. Please enter the email\naddress linked with your account.",
                style: TextStyle(fontSize: 14.sp, height: 1.5),
              ),
              Gap(32.h),
              Form(
                key: _formKey,
                child: CustomTextField(
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                ),
              ),
              Gap(24.h),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : AppButton(
                      text: 'Send Code',
                      onPressed: _onSendCode,
                      isFilled: true,
                      backgroundColor: const Color(0xFFBB9457),
                      textColor: Colors.white,
                    ),
              const Spacer(),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Remember Password? ',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.pushNamedAndRemoveUntil(AppRoutes.login),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFBB9457),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }
}
