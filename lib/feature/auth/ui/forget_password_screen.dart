import 'package:bookia/core/helper/extenstions.dart';
import 'package:bookia/core/routs/app_routs.dart';
import 'package:bookia/core/widgets/custom_app_button.dart';
import 'package:bookia/core/widgets/custom_back_button.dart';
import 'package:bookia/core/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

//TODO add loading design while loading

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendCode() {
    if (_formKey.currentState?.validate() ?? false) {
      context.pushNamed(AppRoutes.otpVerfication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Gap(12.h),
              Text(
                "Don't worry! It occurs. Please enter the email\naddress linked with your account.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
              Gap(32.h),
              Form(
                key: _formKey,
                child: CustomTextField(
                  hintText: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              Gap(24.h),
              AppButton(
                text: 'Send Code',
                onPressed: _onSendCode,
                isFilled: true,
                backgroundColor: const Color(0xFFBB9457),
                textColor: Colors.white,
              ),
              const Spacer(),
              // Remember Password row
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Remember Password? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
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
